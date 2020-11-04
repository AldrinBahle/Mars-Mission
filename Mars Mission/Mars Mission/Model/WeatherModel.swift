//
//  WeatherModel.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

struct WeatherDataModel: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    let daily: WeeklyWeatherData
        
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
        
    struct WeeklyWeatherData: Codable {
        let data: [ForecastData]
    }
    
    struct ForecastData: Codable {
        let time: Date
        let temperatureLow: Double
        let temperatureHigh: Double
        let icon: String
        let humidity: Double
    }
}
