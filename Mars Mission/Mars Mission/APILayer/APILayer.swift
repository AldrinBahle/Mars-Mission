//
//  APILayer.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/04.
//

import Foundation

private var APIBaseURL: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            fatalError("Could Not find the file 'Config.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "APIBaseURL") as? String else {
            fatalError("Could Not find key 'APIBaseURL' in 'Config.plist'.")
        }
        return value
    }
}
