//
//  Parameters.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-05.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import Foundation
import MultiSlider
import UIKit

class Parameter {
    
    var intervalls : [MinMaxValue]
    var tableViewRows : Int
    var rowDescription : [[Int:String]]
    var unit : String
    var selection : [Int]
    var userIntervalls : [MinMaxValue]
    var jsonIntervalls : [Double]
    
    
    init(intervalls: [MinMaxValue], tableViewRows: Int, rowDescription: [[Int:String]], unit: String) {
        self.intervalls = intervalls
        self.selection = []
        self.userIntervalls = []
        self.tableViewRows = tableViewRows
        self.rowDescription = rowDescription
        self.unit = unit
        self.jsonIntervalls = []
    }
    
    convenience init() {
        self.init(intervalls: [], tableViewRows: 0, rowDescription: [], unit: "")
    }
    
    func configure(descriptionStackView: UIStackView, parameter: Parameter) {
    }
    
    
    func configure(intervallStackView: UIStackView, parameter: Parameter) {
        intervallStackView.distribution = .fillEqually
        
        let min = Int(parameter.intervalls[0].min)
        let max = Int(parameter.intervalls[0].max)
        
        for i in stride(from: max, through: min, by: -1) {
            if i%10 == 0 {
                let label = UILabel()
                label.text = "-\(String(i))\(parameter.unit)"
                intervallStackView.addArrangedSubview(label)
            }
            
            if i%5 == 0 {
                let label = UILabel()
                label.text = "\n"
                intervallStackView.addArrangedSubview(label)
            }
            if i == min+1 {
                let label = UILabel()
                label.text = "-\(min)\(parameter.unit)"
                intervallStackView.addArrangedSubview(label)
                break
            }
            
        }
    }
    
    
    func configure(multiSlider: MultiSlider, with parameter: Parameter) {
        
        multiSlider.thumbCount = 2
        multiSlider.valueLabelPosition = .top
        multiSlider.tintColor = .cyan
        multiSlider.trackWidth = 32
        multiSlider.showsThumbImageShadow = true
        multiSlider.valueLabelFormatter = .init()
        
        multiSlider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        multiSlider.addTarget(self, action: #selector(sliderDragEnded(_:)), for: .touchUpInside)
        
        multiSlider.minimumValue = CGFloat(parameter.intervalls[0].min)
        multiSlider.maximumValue = CGFloat(parameter.intervalls[0].max)
        multiSlider.valueLabelFormatter.positiveSuffix = parameter.unit
        multiSlider.valueLabelFormatter.negativeSuffix = parameter.unit
        
        multiSlider.valueLabelPosition = .left
        if parameter.userIntervalls.isEmpty {
            multiSlider.value = [multiSlider.minimumValue, multiSlider.maximumValue]
        } else {
            multiSlider.value = [CGFloat(parameter.userIntervalls[0].min),CGFloat(parameter.userIntervalls[0].max)]
        }
        
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        //print("\(slider.value)")
    }
    
    @objc func sliderDragEnded(_ slider: MultiSlider) {
        userIntervalls.removeAll()
        userIntervalls.append(MinMaxValue(min: Double(slider.value[0]), max: Double(slider.value[1])))
        print(userIntervalls[0].max)
    }
    
    
    
}
