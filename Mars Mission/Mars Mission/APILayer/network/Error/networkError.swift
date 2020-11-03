//
//  networkError.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/03.
//

import Foundation

enum networkError: Error {
    case invalidURL
    case decodingFailed
    case unknown
}
