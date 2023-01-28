//
//  SchoolsViewModel.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 24.01.2023.
//

import Foundation
import Combine

class SchoolsViewModel {
    
    @Published private(set) var schools: [School] = []
    @Published private(set) var error: DataError? = nil
    private let apiService: SchoolAPILogic

    init(apiService: SchoolAPILogic = SchoolAPI()) {
        self.apiService = apiService
    }
    
    //using closure  @escaping ([School]?, DataError?) -> ()
    func getSchools() {
        apiService.getSchools { [weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools ?? []
                //using closure completion(schools, nil)
            case .failure(let error):
                self?.error = error
                //using closure completion([], error)
            }
        }
    }
}
