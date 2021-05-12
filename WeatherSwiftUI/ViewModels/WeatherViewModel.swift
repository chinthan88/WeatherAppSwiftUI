//
//  WeatherViewModel.swift
//  WeatherForecastApp
//
//  Created by Chinthan on 01/06/20.
//  Copyright © 2020 Chinthan. All rights reserved.
//

import UIKit

enum FetchState {
    case idle
    case loading
    case failed(String)
    case fetchCompleted
}

class WeatherViewModel: ObservableObject {
    
    // MARK: - Constants
   private let emptyString = ""
    
    // MARK: - Properties
    
    @Published var currentWeather: WeatherInfo
    @Published var forecasts: [WeatherInfo]
    @Published var fetchStatus: FetchState

    
    // MARK: - init
    init() {
        currentWeather = WeatherInfo(dateTime: emptyString, description: emptyString, currentTemperature: emptyString, maxTemperature: emptyString, minTemperature: emptyString, humidity: emptyString, windSpeed: emptyString, dayName: emptyString, icon: emptyString)
        forecasts = []
        fetchStatus = .idle
    }
    
    func fetchWeatherInfo(location: String) {
        fetchStatus = .loading
        let network: NetworkManager = NetworkManager()
        network.getWeatherData(location: location) { (weather, error) -> Void in
            DispatchQueue.main.async {
                if let weatherDetail = weather {
                    self.updateWeather(weatherDetail)
                }
                if let error = error {
                    self.fetchStatus = .failed(self.updateError(error))
                }
            }
        }
    }
        
    // MARK: - private
    private func updateWeather(_ current: WeatherDetail) -> WeatherInfo {

        var currentInfo: WeatherInfo = WeatherInfo(dateTime: "", description: current.description.capitalized, currentTemperature: "\(current.currentTemperature) °C", maxTemperature: "\(current.maxTemperature) °C", minTemperature: "\(current.minTemperature) °C", humidity: "\(current.humidity) %", windSpeed: "\(current.windSpeed) meter/sec", dayName: DateUtility(date: current.dateTime).getWeekdayName, icon: current.icon)
        currentInfo.currentTemperature = "\(Int(round(current.currentTemperature)))°C"
        currentInfo.maxTemperature = "\(Int(round(current.maxTemperature)))°C"
        currentInfo.minTemperature = "\(Int(round(current.minTemperature)))°C"

        return currentInfo
    }
    
    private func updateWeather(_ weather: Weather) {
        guard let currentWeather = weather.weatherDetails.first else {
            
            self.fetchStatus = .failed(self.updateError(DataManagerError.noData))
            
            return
        }
        self.currentWeather = self.updateWeather(currentWeather)
        self.constructForecastDataModel(fromWeatherDetails: Array(weather.weatherDetails.dropFirst()))
        self.fetchStatus = .fetchCompleted
    }
    
    
    private func updateError(_ error: DataManagerError) -> String {
        var errorMessage = "Something went wrong"
        switch error {
        case .invalidURL, .requestParameterError:
            errorMessage = "The weather service is not working."
        case .networkRequestFailed, .noData:
            errorMessage = "The network appears to be down."
        case .unknown(let errorMsg):
            errorMessage = errorMsg
        case .failedRequest:
            errorMessage = "City not found"
        case .invalidResponse:
            errorMessage = "Something went wrong"
        }
        
        self.forecasts = []
        return errorMessage
    }
    
    private func constructForecastDataModel(fromWeatherDetails weatherDetails: [WeatherDetail]) {
        
        if (weatherDetails.count > 0) {
            var forecastList = [WeatherInfo]()
            for forecast in weatherDetails {
                let weatherInfo = updateWeather(forecast)
                forecastList.append(weatherInfo)
            }
            self.forecasts = forecastList

        } else {
            self.forecasts = []
        }
    }
}

