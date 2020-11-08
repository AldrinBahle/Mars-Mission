//
//  ServiceLayerImplementation.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

class ServiceLayerImplementation: ServiceLayer {
    private let endPoint = "https://run.mocky.io/v3/04dc1be1-8609-48c9-b4a0-27a363aa22a9"
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
                    print(post) //just checking on the console if I'm able to get the API date.
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
