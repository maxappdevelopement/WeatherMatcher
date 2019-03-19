//
//  WindSpeed.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-05.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import Foundation
import Foundation
import MultiSlider

// om vindstyrka: https://sv.wikipedia.org/wiki/Vind

class WindSpeed : Parameter {
    
    var windSpeedIntervalls  = [MinMaxValue(min: 0.0, max: 30.0)]
    var windSpeedUnit : String = "m/s"
    var windSpeedTableViewRows : Int = 30
    var windSpeedRowDescription : [[Int:String]] =
        [
            [30:"Hurricane"],
            [28:"Storm"],
            [24:"Whole Gale"],
            [20:"Strong Gale"],
            [17:"Fresh Gale"],
            [14:"Moderate gale"],
            [11:"Strong breeze"],
            [8:"Fresh breeze"],
            [5:"Moderate breeze"],
            [4:"Gentle breeze"],
            [3:"Light breeze"],
            [2:"Light air"],
            [1:"Calm"],
            ]
    
    override init(intervalls: [MinMaxValue], tableViewRows: Int, rowDescription: [[Int : String]], unit: String) {
        super.init(intervalls: windSpeedIntervalls, tableViewRows: windSpeedTableViewRows, rowDescription: windSpeedRowDescription, unit: windSpeedUnit)
    }
    
    override func configure(multiSlider: MultiSlider, with parameter: Parameter)  {
        super.configure(multiSlider: multiSlider, with: parameter)
    }
    
    
    override func configure(intervallStackView: UIStackView, parameter: Parameter)  {
        
        let min = Int(parameter.intervalls[0].min)
        let max = Int(parameter.intervalls[0].max)
        
        intervallStackView.distribution = .fillEqually
        
        for i in stride(from: max, through: min, by: -1) {
            if i%5 == 0 {
                let label = UILabel()
                label.text = "-\(String(i))\n"
                intervallStackView.addArrangedSubview(label)
            }
            
            if i%5 == 0 {
                let label = UILabel()
                label.text = "\n"
                intervallStackView.addArrangedSubview(label)
            }
            
            if i == min+1 {
                let label = UILabel()
                label.text = "-\(min)"
                intervallStackView.addArrangedSubview(label)
                break
            }
            
        }
        
    }
}
