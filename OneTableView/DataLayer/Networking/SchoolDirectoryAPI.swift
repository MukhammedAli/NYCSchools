//
//  SchoolDirectoryAPI.swift
//  OneTableView
//
//  Created by  Mukhammed Ali Khamzayev on 23.01.2023.
//

import Foundation
import Alamofire

typealias SchoolListAPIResponse =  (Swift.Result<[School]?, DataError>) -> Void

protocol SchoolAPILogic {
    func getSchools(completion: @escaping (Swift.Result<[School]?, DataError>) -> Void)
}

class SchoolAPI : SchoolAPILogic {
    
    private struct Constants {
       static let schoolListURL: String = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=L1KwLSwm1yz1N7aWqFCF4dLmM"
    }
    
    func getSchools(completion: @escaping (SchoolListAPIResponse) ) {
//        //TODO: implement me
        AF.request(Constants.schoolListURL)
            .validate()
            .responseDecodable(of: [School].self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let schools):
                    completion(.success(schools))
                }
            }
////        print("implement get schools")
////        print(Constants.schoolListURL)
//        retrieveSchoolsUsingStandardServices()
    }
    
    private func retrieveSchoolsUsingStandardServices() {
          var  urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        urlComponents.path = "/resource/s3k6-pzi2.json"
        urlComponents.queryItems = [URLQueryItem(name: "$$app_token", value: "L1KwLSwm1yz1N7aWqFCF4dLmM")]
        URL(string: Constants.schoolListURL)
        
        if let url = urlComponents.url {
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { data, response, error in
                guard  error == nil else {
                    print("error occured \(error?.localizedDescription)")
                     return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do{
                        let schools = try decoder.decode([School].self, from: data)
                    print("schools \(schools)")
                    } catch let error {
                        
                    }
                }
            }
            task.resume()
            
        }
        
    }
}
