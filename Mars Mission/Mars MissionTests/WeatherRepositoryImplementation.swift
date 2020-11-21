//
//  WeatherRepositoryImplementation.swift
//  Mars MissionTests
//
//  Created by Aldrin Bahle Gama on 2020/11/17.
//

import XCTest
@testable import Mars_Mission

class WeatherRepositoryImplementationTests: XCTestCase {
    
    var mockService = MockService()
    
    var systemUnderTest: WeatherRepositoryImplementation!
    
    override func setUpWithError() throws {
        systemUnderTest = WeatherRepositoryImplementation(service: mockService)
    }

    override func tearDownWithError() throws {
        systemUnderTest = nil
    }
    
    func testWeatherServiceSuccess() throws {
        
        var weatherResults: WeatherDataModel?
        
        systemUnderTest?.fetchData(completion: {result in weatherResults = try? result.get()})
        
        XCTAssertNotNil(weatherResults)
    }
    
    func testWeatherServiceFailure() {
        mockService.shouldReturnError = true
        
        var weatherResults: WeatherDataModel?
        
        systemUnderTest?.fetchData(completion: {result in weatherResults = try? result.get()})
        
        
    }
}
