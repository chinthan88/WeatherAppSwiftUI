//
//  WeatherDetail.swift
//  WeatherForecastApp
//
//  Created by Chinthan on 01/06/20.
//  Copyright © 2020 Chinthan. All rights reserved.
//

struct WeatherDetail {
    
    let dateTime: String
    var description = ""
    var currentTemperature: Float
    let maxTemperature: Float
    let minTemperature: Float
    let humidity: Float
    let windSpeed: Float
    var icon: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case dateTime = "dt_txt"
        case main
        case weather
        case wind
    }
    
    enum MainKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
    
    enum WeatherKeys: String, CodingKey {
        case description
        case icon = "main"
    }
    
    enum WindKeys: String, CodingKey {
        case windSpeed = "speed"
    }
    
}

extension WeatherDetail: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dateTime = try values.decodeIfPresent(String.self, forKey: .dateTime) ?? ""

        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        currentTemperature = try mainValues.decodeIfPresent(Float.self, forKey: .currentTemperature) ?? 0.0
        minTemperature = try mainValues.decodeIfPresent(Float.self, forKey: .minTemperature) ?? 0.0
        maxTemperature = try mainValues.decodeIfPresent(Float.self, forKey: .maxTemperature) ?? 0.0
        humidity = try mainValues.decodeIfPresent(Float.self, forKey: .humidity) ?? 0.0
     
        var weatherValues = try values.nestedUnkeyedContainer(forKey:.weather)

        while (!weatherValues.isAtEnd) {
            let weatherInfo = try weatherValues.nestedContainer(keyedBy: WeatherKeys.self)
            description = try weatherInfo.decodeIfPresent(String.self, forKey: .description) ?? ""
            icon = try weatherInfo.decodeIfPresent(String.self, forKey: .icon) ?? ""
        }
        
        let windValues = try values.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try windValues.decodeIfPresent(Float.self, forKey: .windSpeed) ?? 0.0
    }
    
    
}
