//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherInfoViewController: UIViewController {
  
  var weatherInfo: WeatherInfo?
  
  @IBOutlet weak var placeNameLabel: UILabel!
  
  @IBOutlet weak var tableView: UITableView!
  var location: CLLocationCoordinate2D!
  let presenter = WeatherInfoPresenter()
  
  var cells = [WeatherInfoCellObject]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    placeNameLabel.text = ""
    
    let lat = location.latitude
    let lng = location.longitude
   
    tableView.registerNibFrom(WeatherInfoCell.self)
    tableView.allowsSelection = false
    tableView.tableFooterView = UITableView(frame: CGRect.zero)
    
    presenter.setDelegateView(view: self)
    presenter.getWeatherInfo(lat: lat, lng: lng)
  }
  
  func displayInformationLoaded(weatherInfo: WeatherInfo) {
    
    let country = weatherInfo.sys?.country
    
    if let country = country {
      placeNameLabel.text = (weatherInfo.name ?? "") + " - " + country
    } else {
      placeNameLabel.text = weatherInfo.name
    }
    
    
    // temp
    let temp: String
    if let _temp = weatherInfo.main?.temp {
      temp = "\(_temp)F"
    } else {
      temp = "--"
    }
    cells.append(WeatherInfoCellObject(description: "Temperature", value: temp))
    
    let tempMax: String
    if let _tempMax = weatherInfo.main?.tempMax {
      tempMax = "\(_tempMax)F"
    } else {
      tempMax = "--"
    }
    cells.append(WeatherInfoCellObject(description: "Maximum temperature", value: tempMax))
    
    let tempMin: String
    if let _tempMin = weatherInfo.main?.tempMin {
      tempMin = "\(_tempMin)F"
    } else {
      tempMin = "--"
    }
    cells.append(WeatherInfoCellObject(description: "Minimum temperature", value: tempMin))
    
    if let pressure = weatherInfo.main?.pressure {
      cells.append(WeatherInfoCellObject(description: "Pressure", value: "\(pressure)"))
    }

    cells.append(WeatherInfoCellObject(description: "WEATHER", value: ""))
    for (index, weater) in weatherInfo.weather.enumerated() {
      if let main = weater.main {
        cells.append(WeatherInfoCellObject(description: "Weather \(index) - Main", value: main))
      }
      if let description = weater.description {
        cells.append(WeatherInfoCellObject(description: "Weather \(index) - Description", value: description))
      }
    }
    
    if let visibility = weatherInfo.visibility {
      cells.append(WeatherInfoCellObject(description: "Visibility", value: "\(visibility)m"))
    }
    
    if let windSpeed = weatherInfo.wind?.speed {
      cells.append(WeatherInfoCellObject(description: "Wind speed", value: "\(windSpeed)"))
    }
    
    if let windDegrees = weatherInfo.wind?.deg {
      cells.append(WeatherInfoCellObject(description: "Wind degrees", value: "\(windDegrees)"))
    }
    
    
    tableView.reloadData()
  }
}

extension WeatherInfoViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellObject = cells[indexPath.row]
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellObject.reusable, for: indexPath) as? WeatherInfoCell else {
      return UITableViewCell()
    }
    cell.setup(weatherInfoCellObject: cellObject)
    return cell
  }
}

extension WeatherInfoViewController: WeatherInfoView {
  func createAlert(title: String, message: String) {
    showNotification(title: title, message: message)
  }
  
  func updateInfo(weatherInfo: WeatherInfo) {
    self.weatherInfo = weatherInfo
    displayInformationLoaded(weatherInfo: weatherInfo)
  }
  
  
}
