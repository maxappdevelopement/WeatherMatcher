//
//  Date+Display.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-12.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    //formatter.locale = Locale(identifier: "sv")
    //formatter.dateStyle = .short
    //kolla vad användaren har för kalenderinställningar?
    
    func displayDate(date: Date) -> String {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let inputDate = self.string(from: date)
        
            if let convertDate = self.date(from: inputDate) {
                self.dateFormat = "E d MMM HH:mm"
                let convertedDate = self.string(from: convertDate)
                return convertedDate
            }
        return ""
        }
        
}
    

