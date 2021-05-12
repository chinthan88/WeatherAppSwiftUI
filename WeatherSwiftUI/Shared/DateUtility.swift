//
//  DateUtility.swift
//  WeatherForecastApp
//
//  Created by Chinthan on 01/06/20.
//  Copyright © 2020 Chinthan. All rights reserved.
//

import Foundation

struct DateUtility {
    
   private let rawDate: String
    
    init(date: String) {
        self.rawDate = date
    }
    
    var getWeekdayName: String {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current

        guard let  date =  dateFormatter.date(from: rawDate) else { return "" }
        let weekday = Calendar.current.component(.weekday, from: date)
        let formatedString = formatter.string(from: date)

        switch weekday {
        case 1:
            return "SUN \(formatedString)"
        case 2:
            return "MON \(formatedString)"
        case 3:
            return "TUE \(formatedString)"
        case 4:
            return "WED \(formatedString)"
        case 5:
            return "THU \(formatedString)"
        case 6:
            return "FRI \(formatedString)"
        case 7:
            return "SAT \(formatedString)"
        default:
             return "SUN \(formatedString)"
        }
    }
    
}
