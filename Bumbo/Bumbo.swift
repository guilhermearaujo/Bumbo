//
//  Bumbo.swift
//  Bumbo
//
//  Created by Guilherme Araújo on 15/03/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

/**
 Bumbo

 _A swifty client for [Thumbor](https://github.com/thumbor/thumbor)_
 */
public class Bumbo {
  static var host: String?
  static var secretKey: String?

  /// Trim removes surrounding space in images
  public enum TrimCorner: String {
    /// uses bottom-right pixel's color
    case bottomRight = "bottom-right"

    /// uses top-left pixel's color
    case topLeft = "top-left"
  }

  /// Image format
  public enum Format: String {
    /// GIF
    case gif

    /// JPEG
    case jpeg

    /// PNG
    case png

    /// WebP
    case webp
  }

  /// Vertical alignment controls height trimming.
  public enum VerticalAlign: String {
    /// Keeps the top and trims the bottom
    case top

    /// Keeps the middle and trims both top and bottom
    case middle

    /// Keeps the bottom and trims the top
    case bottom
  }

  /// Horizontal alignment controls width trimming.
  public enum HorizontalAlign: String {
    /// Keeps the left side and trims the right side
    case left

    /// Keeps the middle and trims both sides
    case center

    /// Keeps the right side and trims the left side
    case right
  }

  /**
   Setup Thumbor server with host and secret key.
   - parameter host: A URI to Thumbor server
   - parameter secretKey: The encryption key configured in the server
   */
  public static func configure(host: String, secretKey: String?) {
    self.host = host
    self.secretKey = secretKey
  }

  /**
   Load and resize an image.
   - parameter url: A URI to the original image
   - parameter width: The desired image width
   - parameter height: The desired image height
   - returns: A builder which filters and settings can be applied to
   */
  static public func load(_ url: String) -> Builder {
    return Builder(url: url)
  }

  static func unsafe() -> Bool {
    return secretKey == nil
  }
}
