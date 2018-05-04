//
//  UITableView+extension.swift
//  Weather
//
//  Created by Breno Pinto on 03/05/18.
//  Copyright © 2018 Breno Pinto. All rights reserved.
//

import UIKit

extension UITableView {
  func registerNibFrom(_ cellClass: UITableViewCell.Type) {
    let nib = UINib(nibName: cellClass.className(), bundle: nil)
    self.register(nib, forCellReuseIdentifier: cellClass.className())
  }
}
