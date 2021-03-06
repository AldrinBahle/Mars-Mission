//
//  WeatherModel.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

struct WeatherDataModel: Codable {
    var forecasts: [Forecasts]?
    var lastUpdated: String?
    var weatherStation: String?
}

struct Forecasts: Codable {
    var date: String?
    var temp: Double?
    var humidity: Int?
    var windSpeed: Int?
    var safe: Bool?
}

    
