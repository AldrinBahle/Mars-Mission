//
//  WeatherModel.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

struct WeatherDataModel: Codable, Hashable {
    var forecasts: [Forecasts]!
    var lastUpdated: String?
    var weatherStation: String?
}

struct Forecasts: Codable, Hashable {
    var date: String?
    var temp: Double?
    var humidity: Int?
    var windSpeed: Int?
    var safe: Bool?
}

    
