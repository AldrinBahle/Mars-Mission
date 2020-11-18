//
//  MockService.swift
//  Mars MissionTests
//
//  Created by Aldrin Bahle Gama on 2020/11/17.
//

import Foundation
@testable import Mars_Mission

class MockService: ServiceLayer {
    
    var shouldReturnError = false
    
    enum MockError: Error {
        case serviceError
    }
    
    func reset() {
        shouldReturnError = false
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    convenience init() {
        self.init(false)
    }
    
    func fetchData(completion: @escaping (Result<WeatherDataModel, Error>) -> Void) {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "WeatherDataModel", ofType: "json") else {
            fatalError("json not found")
        }
        
        guard let json = try?String(contentsOfFile: filePath, encoding: .utf8) else {
            fatalError("Unable to convcert json to String")
        }
        let weather = json.data(using: .utf8)!
        let weatherData = try!JSONDecoder().decode(WeatherDataModel.self, from: weather)
        
        shouldReturnError == true ? completion(.failure(MockError.serviceError)): completion(Result.success(weatherData))
    }
}
