//
//  WeatherInfo.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import Foundation

class WeatherInfo {
  var weather = [Weather]()
  
  var main: Main?
  var visibility: Int?
  var wind: Wind?
  var clouds: Int?
  var sys: Sys?
  var name: String?
  
  static func parse(json: [String:Any]) -> WeatherInfo {
    let weather = WeatherInfo()
    weather.visibility = json["visibility"] as? Int
    
    if let sys = json["sys"] as? [String:Any] {
      weather.sys = Sys.parse(json: sys)
    }
    if let wind = json["wind"] as? [String:Any] {
      weather.wind = Wind.parse(json: wind)
    }
    
    if let main = json["main"] as? [String:Any] {
      weather.main = Main.parse(json: main)
    }
    
    weather.name = json["name"] as? String
    
    if let weathersJson = json["weather"] as? [[String:Any]] {
      for weatherJson in weathersJson {
        weather.weather.append(Weather.parse(json: weatherJson))
      }
    }
    
    if let clouds = json["clouds"] as? [String:Any] {
      if let all = clouds["all"] as? Int {
        weather.clouds = all
      }
    }
    return weather
  }
}

class Main {
  var temp: Double?
  var pressure: Int?
  var humidity: Int?
  var tempMin: Double?
  var tempMax: Double?
  
  static func parse(json: [String:Any]) -> Main {
    let main = Main()
    main.temp = json["temp"] as? Double
    main.pressure = json["pressure"] as? Int
    main.humidity = json["humidity"] as? Int
    main.tempMin = json["temp_min"] as? Double
    main.tempMax = json["temp_max"] as? Double
    return main
  }
}

class Sys {
  var type, id: Int?
  var message: Double?
  var country: String?
  var sunrise, sunset: Int?
  
  static func parse(json: [String:Any]) -> Sys {
    let sys = Sys()
    sys.type = json["type"] as? Int
    sys.id = json["id"] as? Int
    sys.message = json["message"] as? Double
    sys.country = json["country"] as? String
    sys.sunrise = json["sunrise"] as? Int
    sys.sunset = json["sunset"] as? Int
    return sys
  }
}

class Weather {
  var main, description: String?
  
  static func parse(json: [String:Any]) -> Weather {
    let weather = Weather()
    weather.main = json["main"] as? String
    weather.description = json["description"] as? String
    return weather
  }
}

class Wind {
  var speed: Double?
  var deg: Int?
  
  static func parse(json: [String:Any]) -> Wind {
    let wind = Wind()
    wind.speed = json["speed"] as? Double
    wind.deg = json["deg"] as? Int
    return wind
  }
  

}

