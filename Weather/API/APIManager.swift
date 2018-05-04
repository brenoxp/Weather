//
//  APIManager.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import Foundation
import Alamofire


class APIManager  {
  
  static func request(_ url: String, method: HTTPMethod, parameters: [String: Any]? = nil, completion: @escaping (_ success: Bool, _ message: String?, _ response: Any?) -> ()) {
    Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
      switch response.result {
      case .success:
        let data = response.result.value
        switch response.response!.statusCode {
        case 200:
          //Return data
          var message: String?
          completion(true, message, data)
        case 204:
          completion(true, nil, nil)
        case 400..<500:
          ()
        default:
          completion(false, kRequest.messageServerUnavailable, nil)
        }
      case .failure(_):
        completion(false, kRequest.messageServerUnavailable, nil)
      }
    }
  }

}


