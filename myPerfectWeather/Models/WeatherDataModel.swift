//
//  WeatherDataModel.swift
//  myPerfectWeather
//
//  Created by Max Friman on 2019-03-10.
//  Copyright © 2019 Max Friman. All rights reserved.
//


import Foundation

//___________________Decoding Weather Json__________________________________

//WeatherDataModel--------------------------------------------
    struct WeatherDataModel : Decodable {
        var approvedTime : Date
        var geometry: Geometry
        var timeSeries : [Timeseries]
    }
    
    //Geometry--------------------------------------------
    struct Geometry : Decodable {
        var type :String
        var coordinates :[Coordinates]
    }
    
    //Coordinates-----------------------------------------
    struct Coordinates : Decodable {
        var latitude :Double
        var longitude :Double
        
        init(from decoder :Decoder) throws {
            if var container = try? decoder.unkeyedContainer() {
                self.latitude = try container.decode(Double.self)
                self.longitude = try container.decode(Double.self)
            } else {
                let context = DecodingError.Context.init(codingPath: decoder.codingPath, debugDescription:
                    "Unable to decode coordinates")
                throw DecodingError.dataCorrupted(context)
            }
        }
    }
    
    //Timeseries-----------------------------------------
    struct Timeseries : Decodable {
        var validTime : Date
        var parameters : [Parameters]
        
        private enum CodingKeys :String, CodingKey {
            case validTime
            case parameters
        }
        
        init(from decoder :Decoder) throws {
            
            if let container = try? decoder.container(keyedBy: CodingKeys.self) {
                self.validTime = try container.decode(Date.self, forKey: .validTime)
                self.parameters = try container.decode([Parameters].self, forKey: .parameters)
            } else {
                let context = DecodingError.Context.init(codingPath: decoder.codingPath, debugDescription:
                    "Unable to decode timeseries")
                throw DecodingError.dataCorrupted(context)
            }
        }
    }
    
    //Parameters-----------------------------------------
    struct Parameters : Decodable {
        var name :String
        var level :Int
        var unit :String
        var values :[Values]
        
        private enum CodingKeys :String, CodingKey {
            case name
            case level
            case unit
            case values = "values"
        }
        
        init(from decoder :Decoder) throws {
            
            if let container = try? decoder.container(keyedBy: CodingKeys.self) {
                self.name = try container.decode(String.self, forKey: .name)
                self.level = try container.decode(Int.self, forKey: .level)
                self.unit = try container.decode(String.self, forKey: .unit)
                self.values = try container.decode([Values].self, forKey: .values)
            } else {
                let context = DecodingError.Context.init(codingPath: decoder.codingPath, debugDescription:
                    "Unable to decode parameters")
                throw DecodingError.dataCorrupted(context)
            }
        }
    }
    
    //Values------------------------------------------------
    struct Values : Decodable {
        
        let value :Any
        
        init<T>(_ value :T?) {
            self.value = value ?? ()
        }
        
        init(from decoder :Decoder) throws {
            
            let container = try decoder.singleValueContainer()
            
            if let double = try? container.decode(Double.self) {
                self.init(double)
            } else if let int = try? container.decode(Int.self) {
                    self.init(int)
            } else if let string = try? container.decode(String.self) {
                self.init(string)
            } else {
                self.init(())
            }
            
        }
        
    }
    

