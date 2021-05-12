//
//  DailyForeCastView.swift
//  WeatherSwiftUI
//
//  Created by Chinthan on 11/05/21.
//  Copyright © 2021 Chinthan. All rights reserved.
//

import SwiftUI

struct DailyForeCastView: View {
    let weather: WeatherInfo

    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color(UIColor.systemPurple))
                    .shadow(radius: 15)

                VStack {
                    Text(self.weather.dayName)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(self.weather.currentTemperature)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, -10)
                    Image(uiImage:  UIImage.weatherIcon(of: self.weather.icon)!)
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75, alignment: .center )
                        .padding(.bottom, -15)

                    Text(self.weather.description)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)

                    HStack(alignment: .center) {
                            Text(self.weather.minTemperature)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                            Spacer()
                            Text(self.weather.maxTemperature)
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                    }
                }
                .padding(.all, 20.0)
                .multilineTextAlignment(.center)
            }
            .frame(width: 150, height: 210)
            .padding(.trailing, 10)
    }
}

struct DailyForeCastView_Previews: PreviewProvider {
    static var previews: some View {
        DailyForeCastView(weather: WeatherInfo.example)
    }
}
