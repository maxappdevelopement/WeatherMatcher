//
//  Humidity.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-05.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import Foundation

import Foundation
import MultiSlider
import UIKit

class Humidity: Parameter {
    
    var humidityIntervalls : [MinMaxValue] = [MinMaxValue(min: 0, max: 100)]
    var humidityUnit : String = "%"
    var humidityTableViewRows : Int = 10
    var humidityRowDescription : [[Int:String]] =
        [
            [10:"💦"],
            [9:""],
            [8:""],
            [7:""],
            [6:""],
            [5:""],
            [4:""],
            [3:""],
            [2:""],
            [1:"🌵"],
        ]
    
    override init(intervalls: [MinMaxValue], tableViewRows: Int, rowDescription: [[Int : String]], unit: String) {
        super.init(intervalls: humidityIntervalls, tableViewRows: humidityTableViewRows, rowDescription: humidityRowDescription, unit: humidityUnit)
    }
    
    
    override func configure(multiSlider: MultiSlider, with parameter: Parameter)  {
        super.configure(multiSlider: multiSlider, with: parameter)
    }
    
    
    override func configure(intervallStackView: UIStackView, parameter: Parameter)  {
        super.configure(intervallStackView: intervallStackView, parameter: parameter)
    }
    
}
