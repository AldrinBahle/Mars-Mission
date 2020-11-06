//
//  WeatherRepositoryImplementation.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

class WeatherRepositoryImplementation: WeatherRepository {
    
    private let service = ServiceLayerImplementation()
    
    func fetchData(completion: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        service.fetchData { (result) in
            switch result {
            case .success(let post):
                completion(.success(post))
            case  .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
