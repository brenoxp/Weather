//
//  APIConstants.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import Foundation

struct APIConstants {
  static let base = "https://api.openweathermap.org/data/2.5"
  static let appId = "9cf4e78f2bb982c13b605a5389df65ad"
}



class kWeather {
  static let info = APIConstants.base + "/weather"
}


struct kRequest {
  static let unexpectedError = "Unexpected error"
  static let messageServerUnavailable = "Server unavailable"
}
