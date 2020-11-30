//
//  ServiceLayerImplementation.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation
import Alamofire

class ServiceLayerImplementation: ServiceLayer {
    fileprivate var baseUrl = ""
    private let endPoint = "https://run.mocky.io/v3/04dc1be1-8609-48c9-b4a0-27a363aa22a9"
    private let serviceError = NSError(domain: "", code: 1, userInfo: nil)
    
    func fetchData(completion: @escaping (Result<WeatherDataModel, Error>) -> Void) {
//        AF.request(self.baseUrl + endPoint, method: .get, encoding: URLEncoding.default).response {
//            (responseData) in
//            print("we got the response")
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


