//
//  ViewController.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!
  let locationManager = CLLocationManager()
  var mapTapGesture: UITapGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
    mapView.showsUserLocation = true
    mapView.delegate = self
    
    mapTapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedMap(tapGesture:)))
    mapTapGesture.numberOfTapsRequired = 2
    mapTapGesture.delegate = self
    mapView.addGestureRecognizer(mapTapGesture)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "weatherInfoSegue") {
      let viewController = segue.destination as! WeatherInfoViewController
      viewController.location = sender as! CLLocationCoordinate2D
    }
  }
  
  
  @objc func tappedMap(tapGesture: UITapGestureRecognizer) {
    let location = tapGesture.location(in: mapView)
    let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
    
    print(coordinate)
    performSegue(withIdentifier: "weatherInfoSegue", sender: coordinate)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension MapViewController: MKMapViewDelegate {
}

extension MapViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    if (otherGestureRecognizer == mapTapGesture) {
      return false
    }
    return true
  }
}


extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .authorizedAlways,
         .authorizedWhenInUse:
      manager.startUpdatingLocation()
    case .restricted,
         .denied:
      showNotification(title: "Ops", message: "Seems that I'm not allowed to get your location. Please, change the location permition on settings.")
    }
  }
}
