//
//  WeatherInfoService.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import Foundation

class WeatherInfoService {
  static func getWeatherInfo(lat: Double, lng: Double, completion: @escaping (_ success: Bool, _ message: String?, _ response: WeatherInfo?) -> ()) {
    
//    let weatherInfo try? JSONDecoder().decode(WeatherInfo.self, from: jsonData)
    
    let parameters = [
      "lat": lat,
      "lon": lng,
      "appid": APIConstants.appId,
      ] as [String : Any]
    
    APIManager.request(kWeather.info, method: .get, parameters: parameters) { (success, message, data) in
      if (success) {
        
        if let data = data as? [String:Any] {
          let weather = WeatherInfo.parse(json: data)
          completion(success, message, weather)
          return
        }
        
        completion(success, kRequest.unexpectedError, nil)
      } else {
        completion(success, kRequest.messageServerUnavailable, nil)
      }
    }
  }
}
