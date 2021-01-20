//
//  Extensions.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import Foundation
extension Date {
    func dateToString(with dateFormatter: DateFormatter) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: self)
        return date
    }
    
    func dateToDayString(with dateFormatter: DateFormatter) -> String {
        dateFormatter.dateFormat = "EEEE"
        let date = dateFormatter.string(from: self)
        return date
    }
    func hours() -> Int {
       return Calendar.current.component(.hour, from: self)
    }
    func shortDate(with dateFormatter: DateFormatter) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateToString(with: dateFormatter))
        return date
    }
    
    func isDay() -> Bool{
        if self.hours() >= 18 || self.hours() <= 6 {
            return false
        }
        return true
    }
}
