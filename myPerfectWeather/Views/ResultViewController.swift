//
//  ResultViewController.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-15.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, WeatherControllerDelegate {
    
    @IBOutlet var resultLabel: UILabel!
    
    var longitude : Double?
    var latitude : Double?
    
    var userParameters : [String:Parameter] = [:]
    var weatherController : WeatherController!
    var matchedDates : [Date]?
    
    func didRecieveMatchedDates(dates: [Date]) {
        print("did recieve dates")
        matchedDates = dates
       
        let formatter = DateFormatter()
        var printText : String = ""
        if matchedDates != [] {
            for element in matchedDates! {
                let displayDate = formatter.displayDate(date: element)
                printText += "\(displayDate)\n"
            }
            self.resultLabel.text = "Your weather will arrive at\n\(printText)"
        } else {
            self.resultLabel.text = "No forecast matched your weather"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherController = WeatherController()
        weatherController.delegate = self
        weatherController.userParameters = userParameters
        
        guard let longitude = longitude else { return }
        guard let latitude = latitude else { return }
        
        weatherController.getWeatherData(latitude: 16.158, longitude: 58.5812)

    }
}




