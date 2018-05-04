//
//  UIViewController+extension.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import UIKit

extension UIViewController {
  func showNotification(title: String, message: String) {
    let notification = UIAlertController(title: title, message: message, preferredStyle: .alert)
    notification.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
      notification.dismiss(animated: true, completion: nil)
    }))
    present(notification, animated: true, completion: nil)
  }
}
