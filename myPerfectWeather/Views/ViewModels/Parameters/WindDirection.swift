//
//  Winddirection.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-05.
//  Copyright © 2019 Max Friman. All rights reserved.
//

//Förklaring: 0° nordlig, 45° nordöstlig, 90°    östlig, 135°    sydöstlig, 180° sydlig, 225°    sydvästlig, 270°    västlig, 315°    nordvästlig och 360° nordlig.

import Foundation
import UIKit

class WindDirection : Parameter {
    
    var windDirectionsIntervall = [MinMaxValue(min: 0, max: 360)] //N
    var windDirectionUnit : String = "°"
    var windDirectionTableViewRows : Int = 9
    var windDirectionTableViewRowDescription : [[Int:String]] =
        [
            [1:"⬆️ North"],
            [2:"↖️ North West"],
            [3:"⬅️ West"],
            [4:"↙️ South West"],
            [5:"⬇️ South"],
            [6:"↘️ South East"],
            [7:"➡️ East"],
            [8:"↗️ North East"],
            [9:"⬆️ North"]
        ]
    
    
    override init(intervalls: [MinMaxValue], tableViewRows: Int, rowDescription: [[Int : String]], unit: String) {
        super.init(intervalls: windDirectionsIntervall, tableViewRows: windDirectionTableViewRows, rowDescription: windDirectionTableViewRowDescription, unit: windDirectionUnit)
    }
    
    override func configure(intervallStackView: UIStackView, parameter: Parameter)  {
        
        let min = Int(parameter.intervalls[0].min)
        let max = Int(parameter.intervalls[0].max)
        
        intervallStackView.distribution = .fillEqually
        
        for i in stride(from: max, through: min, by: -1) {
            
            if i%30 == 0 {
                let label = UILabel()
                label.text = "— \(String(i))\(parameter.unit)"
                intervallStackView.addArrangedSubview(label)
            }
            
            
        }
    }
}

    

