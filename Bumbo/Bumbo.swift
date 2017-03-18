//
//  Bumbo.swift
//  Bumbo
//
//  Created by Guilherme Araújo on 15/03/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

public class Bumbo {
  static var host: String? = nil
  static var secretKey: String? = nil

  public enum TrimCorner: String {
    case bottomRight = "bottom-right"
    case topLeft = "top-left"
  }

  public enum Format: String {
    case gif
    case jpeg
    case png
    case webp
  }

  public enum VerticalAlign: String {
    case top
    case middle
    case bottom
  }

  public enum HorizontalAlign: String {
    case left
    case center
    case right
  }

  public static func configure(host: String, secretKey: String?) {
    self.host = host
    self.secretKey = secretKey
  }

  static public func load(_ url: String, width: Int, height: Int) -> Builder {
    return Builder(url: url, width: width, height: height)
  }

  static func unsafe() -> Bool {
    return secretKey == nil
  }
}
