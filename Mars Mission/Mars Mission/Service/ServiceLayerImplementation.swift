//
//  ServiceLayerImplementation.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

class ServiceLayerImplementation: ServiceLayer {
    private let endPoint = "https://api.nasa.gov/"
    private let serviceError = NSError(domain: "", code: 1, userInfo: nil)
    
    func fetchData(completion: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        guard let url = URL(string: endPoint) else {
            completion(.failure(serviceError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            do {
                if let error = error {
                    completion(.failure(error))
                }
                if let data = data {
                    let post = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                    completion(.success(post))
                }
                else {
                    completion(.failure(self.serviceError))
                }
            }
            catch(let error) {
                completion(.failure(error))
            }
        })
        task.resume()
    }
}
