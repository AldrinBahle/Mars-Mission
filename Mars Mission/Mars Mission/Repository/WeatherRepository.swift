//
//  WeatherRepository.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

protocol WeatherRepository {
    func fetchData(completion: @escaping (Result<WeatherDataModel, Error>) -> Void)
}

