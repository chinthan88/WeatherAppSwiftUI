//
//  SwiftUIView.swift
//  WeatherSwiftUI
//
//  Created by Chinthan on 11/05/21.
//  Copyright © 2021 Chinthan. All rights reserved.
//

import SwiftUI

struct CurrentWeatherView: View {
    let weather: WeatherInfo

    var body: some View {
        GeometryReader { metrics in
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.systemIndigo))
                    .shadow(radius: 5)

                VStack() {
                    Text("Current Weather")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()

                    Text(self.weather.currentTemperature)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(self.weather.description)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()

                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("Humidity \(self.weather.humidity)")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.white)

                            Text(self.weather.windSpeed)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .padding(.top, -2.0)
                                
                        }
                        Spacer()
                        Image(uiImage:  UIImage.weatherIcon(of: self.weather.icon)!)

                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .padding([.top, .leading, .trailing], 30.0)
            
        }
        
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(weather: WeatherInfo.example)
    }
}
