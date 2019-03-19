//
//  WeatherController.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-12.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import Foundation

protocol WeatherControllerDelegate {
    func didRecieveMatchedDates(dates: [Date])
}

class WeatherController: JsonDataDelegate {
    
    var delegate : WeatherControllerDelegate?
    
    var weatherDataModel : WeatherDataModel?
    var userParameters : [String:Parameter] = [:]
    
    var dates : [Date]?
    var matchedDates : [Date] = []
    
    enum Json {
        static let windSpeed = "ws"
        static let temperature = "t"
        static let windDirection = "wd"
        static let airPressure = "msl"
        static let humidity = "r"
        static let visibility = "vis"
        static let thunder = "tstm"
    }
    
    enum User {
        static let windSpeed = "WindSpeed"
        static let temperature = "Temperature"
        static let windDirection = "WindDirection"
        static let airPressure = "AirPressure"
        static let humidity = "Humidity"
        static let visibility = "Visibility"
        static let thunder = "Thunder"
    }
    
    func didReceiveJsonData(weatherDataModel: WeatherDataModel) {
        print("did Recieve it")
        self.weatherDataModel = weatherDataModel;
        populateWeatherParameters()
    }

    func getWeatherData(latitude: Double, longitude: Double) {
        let jsonData = JsonData()
        jsonData.delegate = self
        jsonData.requestJsonWeatherData()
    }
    
    func populateWeatherParameters() {
        cleanseJsonValues()
        
        if let weatherDataModel = weatherDataModel {
            
            dates = [Date]()
            
            for (key, _) in weatherDataModel.timeSeries.enumerated() { //gå igenom alla timeseries
                
                dates!.append(weatherDataModel.timeSeries[key].validTime) // varje forecast date ca 72
                
                for (_, parameter) in weatherDataModel.timeSeries[key].parameters.enumerated() {
                    
                    if (parameter.name==Json.windSpeed ) { //lägger in data för varje date
                        let windSpeed = userParameters[User.windSpeed] ?? Parameter()
                        windSpeed.jsonIntervalls.append(parameter.values[0].value as! (Double))
                    }
                    
                    if (parameter.name==Json.temperature) {
                        let temperature = userParameters[User.temperature] ?? Parameter()
                        temperature.jsonIntervalls.append(parameter.values[0].value as! (Double))
                    }
                    
                    if (parameter.name==Json.windDirection) {
                        let windDirection = userParameters[User.windDirection] ?? Parameter()
                        windDirection.jsonIntervalls.append(parameter.values[0].value as! (Double))
                    }
                    
                    if (parameter.name==Json.humidity) {
                        let humidity = userParameters[User.humidity] ?? Parameter()
                        humidity.jsonIntervalls.append(parameter.values[0].value as! (Double))
                    }
                    
                }
            }
               compareWeatherParameters()
        }
       
    }
    
    
    func compareWeatherParameters() {
        
        var comparator = WeatherComparator(with: [], with: [], and: [])
        for parameter in userParameters {
    
            comparator = WeatherComparator(with: parameter.value.jsonIntervalls, with: dates!, and: parameter.value.userIntervalls)
            let date = comparator.compareValues()
            matchedDates += date //bygger på array av matchade datum så att alla datum där jsonValues matchat med userIntervalls ligger i en enda stor datearray

            }
        
        var allMacthes = comparator.dateOccursInAll(allmatches: matchedDates, valuesSentIn: userParameters.count)
        allMacthes.sort()
        
        if let delegate = self.delegate {
        delegate.didRecieveMatchedDates(dates: allMacthes)
        }
        
        }
    
        func cleanseJsonValues() {
            for item in userParameters {
            item.value.jsonIntervalls.removeAll()
        }
    
    }
        
        
      
        
//        let windSpeedComparator = WeatherComparator(with: windSpeeds!, with: dates!, and: userParameters[0].userIntervalls)
//        let b = windSpeedComparator.compareValues()
//        //windSpeedComparator.
//        print(b)
//
//        let temperatureComparator = WeatherComparator(with: temperatures!, with: dates!, and: userTemperatures)
//        let c = temperatureComparator.compareValues()
//        print(c)
//
//        let a = b + c
//        var d = windSpeedComparator.occursEnoughAmountOfTimes(allmatches: a, valuesSentIn: 2)
//        d.sort()
//
        //print(d.count)
        
    }
    
    
//    let userWindSpeeds = [//UserMinMaxValues(min: 1.0, max: 2.0),
//                          MinMaxValue.init(min: 2.9, max: 3.6)]
//                          //UserMinMaxValues.init(min: 4.0, max: 5.3)]
//
//
//    let userTemperatures = [MinMaxValue.init(min: 0.0, max: 2.0)]
//                            //UserMinMaxValues.init(min: 3.0, max: 4.0),
//                            //UserMinMaxValues.init(min: 1.0, max: 2.0)]

    
    
        //let winds = WeatherComparator(with: windspeed, with: dates, and: userWindSpeeds<T>)
        //let temperatures = WeatherComparator(with: temperature, with: dates, and: userTemperatures)
    
   

   



