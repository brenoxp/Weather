//
//  WeatherInfoPresenter.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import Foundation

protocol WeatherInfoView: NSObjectProtocol {
  func createAlert(title: String, message: String)
  func updateInfo(weatherInfo: WeatherInfo)
}

class WeatherInfoPresenter {
  weak fileprivate var view: WeatherInfoView?
  
  func setDelegateView(view: WeatherInfoView) {
    self.view = view
  }
  
  func getWeatherInfo(lat: Double, lng: Double) {
    
    WeatherInfoService.getWeatherInfo(lat: lat, lng: lng) { (success, message, data) in
      if let weatherInfo = data {
        self.view?.updateInfo(weatherInfo: weatherInfo)
      } else {
        if let message = message {
          self.view?.createAlert(title: "", message: message)
        }
      }
    }
  }
}
