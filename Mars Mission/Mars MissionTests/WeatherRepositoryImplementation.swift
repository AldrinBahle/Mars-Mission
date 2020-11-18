//
//  WeatherRepositoryImplementation.swift
//  Mars MissionTests
//
//  Created by Aldrin Bahle Gama on 2020/11/17.
//

import XCTest
@testable import Mars_Mission

class WeatherRepositoryImplementation: XCTestCase {
    
    var mockService = MockService()
    
    var systemUnderTest: WeatherRepositoryImplementation!
    
    override func setUpWithError() throws {
        systemUnderTest = WeatherRepositoryImplementation()
    }

    override func tearDownWithError() throws {
        systemUnderTest = nil
    }
    
    func testWeatherServiceSuccess() throws {
        
        //var weatherResults: WeatherDataModel?
        
       // systemUnderTest?.fetchData(completion: {result in weatherResults = try? result.get()})
    }
}
