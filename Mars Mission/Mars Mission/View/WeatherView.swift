//
//  WeatherView.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/06.
//

import Foundation

protocol WeatherView {
    func configureTitle(_ title: String)
    func showWeatherView()
    func hideWeatherView()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func populateWeather(_ date: String, _ temp: Double, _ humidity: Int, _ windSpeed: Int, _ safe: Bool)
}
