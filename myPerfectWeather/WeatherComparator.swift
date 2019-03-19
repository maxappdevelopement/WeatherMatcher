//
//  WeatherComparator.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-12.
//  Copyright © 2019 Max Friman. All rights reserved.
//
//weatherPlanner
import Foundation

class WeatherComparator {
    
    var jsonValues : [Double]
    var jsonDates : [Date]
    var userValues : [MinMaxValue]
    
    init(with jsonValues: [Double], with jsonDates: [Date], and userValues: [MinMaxValue]) {
        self.jsonValues = jsonValues
        self.jsonDates = jsonDates
        self.userValues = userValues
    }
    
 //Compare Userinput with JsonInput---------------------------------------------------
    func compareValues() -> [Date] {
        var matchedDates = [Date]()
        
        for (indexDate, jsonValue) in self.jsonValues.enumerated() {
            let date = self.jsonDates[indexDate]
            
            for (index, _) in self.userValues.enumerated() {
                
                let isMatch = match(jsonValue, between: self.userValues[index].min, and: self.userValues[index].max)
                
                if isMatch {
                    matchedDates.append(date)
                }
                //        print("Its \(isMatch) that \(jsonValue) is between",
                //            "\(self.userValues[index].min) and \(self.userValues[index].max) at \(date) ")
            }
        }
        return matchedDates
    }
    
    func match(_ jsonValue: Double, between minValue: Double, and maxValue: Double) -> Bool {
        if jsonValue > minValue && jsonValue < maxValue {
            return true
        }
        return false
    }
    
    
    func dateOccursInAll(allmatches: [Date], valuesSentIn: Int) -> [Date] {
        var matchedDates = [Date]()
        var counts: [Date: Int] = [:]
        
        for item in allmatches {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        for (key, value) in counts {
            if value >= valuesSentIn {
                matchedDates.append(key)
            }
        }
        return matchedDates
    }

}
