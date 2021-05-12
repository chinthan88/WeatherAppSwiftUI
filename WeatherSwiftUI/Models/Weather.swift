//
//  Weather.swift
//  WeatherForecastApp
//
//  Created by Chinthan on 01/06/20.
//  Copyright © 2020 Chinthan. All rights reserved.
//

import Foundation

struct WeatherInfo {
    var dateTime: String
    var description: String
    var currentTemperature: String
    var maxTemperature: String
    var minTemperature: String
    var humidity: String
    var windSpeed: String
    var dayName: String
    var icon: String
    
    static var example: WeatherInfo {
        WeatherInfo(dateTime: "Mon 6PM", description: "Scatter clouds", currentTemperature: "30 C", maxTemperature: "34 C", minTemperature: "19 C", humidity: "70", windSpeed: "50 m/s", dayName: "Mon", icon: "cloudy")
    }
}

struct Weather {

    let cityName: String
    let country: String
    let weatherDetails : [WeatherDetail]
    
    private enum CodingKeys: String, CodingKey {
        case city
        case weatherDetails = "list"
    }
    
    enum CityKeys: String, CodingKey {
        case cityName = "name"
        case country
    }
}

extension Weather: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weatherDetails = try values.decodeIfPresent([WeatherDetail].self, forKey: .weatherDetails) ?? []
        
        let cityValues = try values.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        cityName = try cityValues.decodeIfPresent(String.self, forKey: .cityName) ?? ""
        country = try cityValues.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
    
}
