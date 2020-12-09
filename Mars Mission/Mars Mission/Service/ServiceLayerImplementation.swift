//
//  ServiceLayerImplementation.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation
import Alamofire

class ServiceLayerImplementation: ServiceLayer {
    private let endPoint = "https://run.mocky.io/v3/04dc1be1-8609-48c9-b4a0-27a363aa22a9"
    private let serviceError = NSError(domain: "", code: 1, userInfo: nil)
    
    func fetchData(completion: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        AF.request(endPoint, method: .get).validate().responseData { response in
            if let error = response.error {
                completion(.failure(error))
            }
            do {
                if let data = response.data {
                    let weatherData = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                    completion(.success(weatherData))
                } else {
                    completion(.failure(self.serviceError))
                }
            }
            catch {
                completion(.failure(error))
            }
        }
    }
}
