//
//  UIImageUtility.swift
//  WeatherForecastApp
//
//  Created by Chinthan on 01/06/20.
//  Copyright © 2020 Chinthan. All rights reserved.
//

import UIKit

extension UIImage {
    class func weatherIcon(of name: String) -> UIImage? {
        switch name {
        case "Clear":
            return UIImage(named: "clear-day")
        case "clear-night":
            return UIImage(named: "clear-night")
        case "Rain":
            return UIImage(named: "rain")
        case "Snow":
            return UIImage(named: "snow")
        case "sleet":
            return UIImage(named: "sleet")
        case "Wind":
            return UIImage(named: "wind")
        case "Clouds":
            return UIImage(named: "cloudy")
        case "partly-cloudy-day":
            return UIImage(named: "partly-cloudy-day")
        case "partly-cloudy-night":
            return UIImage(named: "partly-cloudy-night")
        default:
            return UIImage(named: "clear-day")
        }
    }
    
    class func mapWeatherIcon(of name: String) -> String? {
        switch name {
        case "Clear":
            return "clear-day"
        case "clear-night":
            return "clear-night"
        case "Rain":
            return "rain"
        case "Snow":
            return "snow"
        case "sleet":
            return "sleet"
        case "Wind":
            return "wind"
        case "Clouds":
            return "cloudy"
        case "partly-cloudy-day":
            return "partly-cloudy-day"
        case "partly-cloudy-night":
            return "partly-cloudy-night"
        default:
            return "clear-day"
        }
    }
}
