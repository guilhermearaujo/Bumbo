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

  public enum Format: String {
    case gif = "gif"
    case jpeg = "jpeg"
    case png = "png"
    case webp = "webp"
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
