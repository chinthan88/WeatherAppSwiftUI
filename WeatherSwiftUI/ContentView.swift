//
//  ContentView.swift
//  WeatherSwiftUI
//
//  Created by Chinthan on 10/05/21.
//  Copyright © 2021 Chinthan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = WeatherViewModel()

    var body: some View {
        
        NavigationView {
            switch viewModel.fetchStatus {
            case .idle:
                ActivityIndicator(isAnimating: .constant(true), style: .medium)
            case .fetchCompleted:
                GeometryReader { metrics in
                    
                    VStack(alignment: .leading, spacing: 25.0) {
                        
                        CurrentWeatherView(weather: viewModel.currentWeather)
                            .frame(width: metrics.size.width, height: metrics.size.height * 0.4, alignment: .center)
                        
                        Text("Weather Forecast")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading], 30.0)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing:10){
                                ForEach(self.viewModel.forecasts.indices, id: \.self){ index in
                                    DailyForeCastView(weather: self.viewModel.forecasts[index])
                                }
                            }.padding(30)
                        }.frame(height:220)
                        .padding(.top)
                    }
                    .navigationBarTitle("Weather", displayMode: .inline)
                }
            default:
                ActivityIndicator(isAnimating: .constant(true), style: .large)

            }
            
        }
        .onAppear {
            self.viewModel.fetchWeatherInfo(location: "London,GB")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}





