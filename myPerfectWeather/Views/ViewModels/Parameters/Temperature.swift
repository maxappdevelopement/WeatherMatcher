//
//  Temperature.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-05.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import Foundation
import MultiSlider
import UIKit

class Temperature: Parameter {
    
    var temperatureIntervalls : [MinMaxValue] = [MinMaxValue(min: -40, max: 40)]
    var temperatureUnit : String = "°C"
    var temperatureTableViewRows : Int = 10
    var temperatureDescription : [[Int:String]] =
        [
            [10:"🌶"],
            [9:""],
            [8:""],
            [7:""],
            [6:""],
            [5:""],
            [4:""],
            [3:""],
            [2:""],
            [1:"🥶"],
        ]
    
    override init(intervalls: [MinMaxValue], tableViewRows: Int, rowDescription: [[Int : String]], unit: String) {
        super.init(intervalls: temperatureIntervalls, tableViewRows: temperatureTableViewRows,
                   rowDescription: temperatureDescription, unit: temperatureUnit)
    }
    
    override func configure(multiSlider: MultiSlider, with parameter: Parameter)  {
        super.configure(multiSlider: multiSlider, with: parameter)
    }
    
    override func configure(intervallStackView: UIStackView, parameter: Parameter)  {
        
        let min = Int(parameter.intervalls[0].min)
        let max = Int(parameter.intervalls[0].max)
        
        intervallStackView.distribution = .fillEqually
        
        for i in stride(from: max, through: min, by: -1) {
            
            if i%10 == 0 {
                let label = UILabel()
                label.text = "— \(String(i))"
                intervallStackView.addArrangedSubview(label)
            }
            if i%5 == 0 {
                let label = UILabel()
                label.text = "-\n"
                intervallStackView.addArrangedSubview(label)
            }
            if i == min+1 {
                let label = UILabel()
                label.text = "— \(min)"
                intervallStackView.addArrangedSubview(label)
                break
            }
            
        }
        
    }
    
}
