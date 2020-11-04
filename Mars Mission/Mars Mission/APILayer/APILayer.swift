//
//  APILayer.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

struct API {
    static let nasaAPI = "NYVu6FVU9WwiBBy9zp4iaWveE1SmWlnDFgEy32cH"
    static let key = nasaAPI
    static let baseURL = URL(string: "https://api.nasa.gov")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}
