//
//  dateFormatter.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/18.
//

import Foundation

func convertUCTtoDate(date: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let str = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "MMM dd,yyyy"
    let dateToString = dateFormatter.string(from: str ?? Date())
    
    return dateToString
}
