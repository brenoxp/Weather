//
//  WeatherInfoCell.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import UIKit

class WeatherInfoCellObject {
  var reusable: String!
  
  let description: String
  let value: String
  init(description: String, value: String) {
    self.description = description
    self.value = value
    reusable = "WeatherInfoCell"
  }
}

class WeatherInfoCell: UITableViewCell {
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  
  override func awakeFromNib() {
    descriptionLabel.text = ""
    valueLabel.text = ""
  }
  
  func setup(weatherInfoCellObject: WeatherInfoCellObject) {
    descriptionLabel.text = weatherInfoCellObject.description
    valueLabel.text = weatherInfoCellObject.value
  }
}


