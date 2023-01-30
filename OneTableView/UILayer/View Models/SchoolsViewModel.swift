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
    private(set) var schoolSectionsList: [SchoolSection]?
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
                if schools?.isEmpty == false {
                    self?.prepareSchoolSections()
                }
                //using closure completion(schools, nil)
            case .failure(let error):
                self?.error = error
                //using closure completion([], error)
            }
        }
    }
    func prepareSchoolSections() {
        var listOfSections = [SchoolSection]()
        var schoolDictionary = [String: SchoolSection]()
        
        for school in schools {
            if let city = school.city {
                if schoolDictionary[city] != nil {
                    schoolDictionary[city]?.schools.append(school)
                } else {
                    var newSection = SchoolSection(city: city, schools: [])
                    newSection.schools.append(school)
                    schoolDictionary[city] = newSection
                }
            }
        }
        
        listOfSections = Array(schoolDictionary.values)
        listOfSections.sort {
            return $0.city < $1.city
        }
        schoolSectionsList = listOfSections
        
    }
}
