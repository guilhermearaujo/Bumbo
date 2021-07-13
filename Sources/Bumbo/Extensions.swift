//
//  Extensions.swift
//  Bumbo
//
//  Created by Guilherme Araújo on 15/03/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

extension UIColor {
  var hexColor: String {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0

    getRed(&red, green: &green, blue: &blue, alpha: nil)

    return String(format: "%02x%02x%02x", Int(red * 255), Int(green * 255), Int(blue * 255))
  }
}

extension String {
  func urlSafe() -> String {
    return self.replacingOccurrences(of: "+", with: "-")
      .replacingOccurrences(of: "/", with: "_")
  }
}
