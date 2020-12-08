//
//  WeatherRepositoryImplementation.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

class WeatherRepositoryImplementation: WeatherRepository {
    let repository: ServiceLayer
    
    init(repository: ServiceLayer) {
        self.repository = repository
    }
    
    func fetchData(completion: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        repository.fetchData { (result) in
            switch result {
            case .success(let post):
                completion(.success(post))
            case  .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
