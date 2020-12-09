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
    
    var systemUnderTest: WeatherRepositoryImplementation?
    
    override func setUpWithError() throws {
        systemUnderTest = WeatherRepositoryImplementation(repository: mockService)
    }

    override func tearDownWithError() throws {
        systemUnderTest = nil
    }
    
    func testWeatherServiceSuccess() throws {
        
        var weatherResults: WeatherDataModel?
        
        systemUnderTest?.fetchData(completion: {result in weatherResults = try? result.get()})
        
        if (weatherResults != nil) {
            
            XCTAssertEqual("2020-11-05T22:00:00.000+0000",weatherResults?.forecasts?[0].date)
            XCTAssertEqual(40.0,weatherResults?.forecasts?[1].temp)
            XCTAssertEqual(30,weatherResults?.forecasts?[2].humidity)
            XCTAssertEqual(6000,weatherResults?.forecasts?[3].windSpeed)
            XCTAssertEqual(false,weatherResults?.forecasts?[4].safe)
            XCTAssertEqual("NASA Mars North Weather Station",weatherResults?.weatherStation)
            XCTAssertEqual("2020-11-07T22:00:00.000+0000",weatherResults?.lastUpdated)
            
        }
    }
    
    func testWeatherServiceFailure() {
        mockService.shouldReturnError = true
        
        var weatherResults: WeatherDataModel?
        
        systemUnderTest?.fetchData(completion: {result in weatherResults = try? result.get()})
        
        if (weatherResults != nil) {
            XCTAssertNil(weatherResults?.forecasts?[0].date)
            XCTAssertNil(weatherResults?.forecasts?[1].temp)
            XCTAssertNil(weatherResults?.forecasts?[2].humidity)
            XCTAssertNil(weatherResults?.forecasts?[3].windSpeed)
            XCTAssertNil(weatherResults?.forecasts?[4].safe)
            XCTAssertNil(weatherResults?.weatherStation)
            XCTAssertNil(weatherResults?.lastUpdated)
        }
    }
}
