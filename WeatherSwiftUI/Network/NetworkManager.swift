//
//  NetworkService.swift
//  WeatherForecastApp
//
//  Created by Chinthan on 01/06/20.
//  Copyright © 2020 Chinthan. All rights reserved.
//

import Foundation


enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case invalidURL
    case requestParameterError
    case noData
    case networkRequestFailed
    case unknown(String)
    
    var errorDescription: String {
        
        switch self {
            
        case .invalidURL:
            return "Invalid url"
            
        case .requestParameterError:
            return "Problem with api request parameter"
            
        case .noData:
            return "Record not available"
            
        case .networkRequestFailed:
            return "Api failed"
            
        case .unknown (let errorDesc):
            return errorDesc.isEmpty ? "Unknown error" : errorDesc
            
        case .failedRequest:
            return "City not found"
        case .invalidResponse:
            return "Something went wrong!"
        }
    }
}

final class NetworkManager {

    static let shared = NetworkManager()
    
    typealias CompletionHandler = (Weather?, DataManagerError?) -> Void
    
    func getWeatherData(location: String, completion: @escaping CompletionHandler) {
        let url = URL(string: generateRequestURL(location)!)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
        }).resume()
    }
    
    private func didFinishGettingWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let err = error {
            completion(nil, .unknown(err.localizedDescription))
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print("Response:\(String(describing: json))")
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    
                    let weatherData = try decoder.decode(Weather.self, from: data)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown("Something went wrong!"))
        }
    }
    
    
    private func generateRequestURL(_ location: String) -> String? {
        guard var components = URLComponents(url: Config.baseURL, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = [URLQueryItem(name:"units", value:"metric"), URLQueryItem(name:"q", value:location),
                                 URLQueryItem(name:"appid", value:Config.appID)]
        
        let urlString = components.url?.absoluteString
        print("Url String:\(String(describing: urlString))")
        return urlString
    }
}
