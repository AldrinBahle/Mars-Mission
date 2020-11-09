//
//  WeatherModel.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

struct WeatherDataModel: Codable {
    var forecasts: [WeatherAtrr]!
    var lastUpdated: String?
    var weatherStation: String?
}

struct WeatherAtrr: Codable {
    var date: String?
    var temp: Double?
    var humidity: Int?
    var windSpeed: Int?
    var safe: Bool?
}

