//
//  JsonData.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-02-23.
//  Copyright © 2019 Max Friman. All rights reserved.
//

import Foundation

protocol JsonDataDelegate {
    func didReceiveJsonData(weatherDataModel: WeatherDataModel)
}

class JsonData {
    
    //behöver pmp3g och version uppdateras automatiskt över tid? ja, lös att det hämtar
    //URL COORDINATES, URL_UNIT
    
    var delegate : JsonDataDelegate?
    
    func requestJsonWeatherData() -> Void {
        let weatherUrl = URL(string: "https://opendata-download-metfcst.smhi.se/api/category/pmp3g/version/2/geotype/point/lon/16.158/lat/58.5812/data.json")!
    
    let weatherResource = Resource<WeatherDataModel>(url: weatherUrl) { data in
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let weatherDataModel = try? decoder.decode(WeatherDataModel.self, from: data)
        
        return weatherDataModel
    }
    
        Webservice().load(resource:weatherResource) { result in
            
            if let weatherDataModel = result {
                
                if let delegate = self.delegate {
                    delegate.didReceiveJsonData(weatherDataModel: weatherDataModel)
                }
                
            }
            
        }
        
    }
    
}
