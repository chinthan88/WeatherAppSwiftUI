//
//  Bind.swift
//  WeatherForecastApp
//
//  Created by Chinthan on 01/06/20.
//  Copyright © 2020 Chinthan. All rights reserved.
//

import UIKit

import Foundation

class Bind<T> {
    
    typealias Observer = (T) -> Void
    var bind: Observer?
    
    func bind(_ bind: Observer?) {
        self.bind = bind
        bind?(value)
    }
    
    var value: T {
        didSet {
            bind?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
