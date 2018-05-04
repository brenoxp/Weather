//
//  NSObject+extension.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import Foundation

extension NSObject {
  class func className() -> String {
    let fullName: String = NSStringFromClass(self)
    let range = fullName.range(of: ".")
    if let range = range {
      return fullName.substring(from: range.upperBound)
    }
    return fullName
  }
}
