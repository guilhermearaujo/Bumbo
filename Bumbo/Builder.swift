//
//  Builder.swift
//  Bumbo
//
//  Created by Guilherme Araújo on 15/03/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation
import CryptoSwift

public extension Bumbo {
  /**
    A builder used to apply settings and filters.
   */
  public class Builder {
    var sourceUrl: String = ""
    var width: Int = 0
    var height: Int = 0

    var meta: Bool = false
    var trim: TrimCorner?
    var crop: (leftTop: (x: Int, y: Int), rightBottom: (x: Int, y: Int))?
    var fitIn: Bool = false
    var hAlign: HorizontalAlign?
    var vAlign: VerticalAlign?
    var smartDetectors: Bool = true
    var filters: [Filter] = []

    init(url: String) {
      self.sourceUrl = url
    }

    /**
     Meta provides data regarding the image processing operations that would be performed.
     When meta is used, the resulting URL will return a JSON string, not an image.
     - parameter enabled: Whether meta is enabled or not. Defaults to false if method is not called
     - returns: The builder
     */
    public func meta(_ enabled: Bool = true) -> Self {
      self.meta = enabled
      return self
    }

    /**
     Trim will select the appropriate corner to trim.
     - parameter corner: The corner used while trimming. Defaults to top-left
     - returns: The builder
     */
    public func trim(_ corner: TrimCorner = .topLeft) -> Self {
      self.trim = corner
      return self
    }

    /**
     Crop will define which area of the image should be cropped before resizing and filtering.
     - parameter leftTop: The left-top (x,y) coordinate
     - parameter rightBottom: The right-bottom (x,y) coordinate
     - returns: The builder
     */
    public func crop(leftTop: (x: Int, y: Int), rightBottom: (x: Int, y: Int)) -> Self {
      self.crop = (leftTop, rightBottom)
      return self
    }

    /**
     Fit in specifies that the image should not be auto-cropped, but auto-resized.
     - parameter enabled: Whether fit-in is enabled or not. Defaults to false if method is not called
     - returns: The builder
     */
    public func fitIn(_ enabled: Bool = true) -> Self {
      self.fitIn = enabled
      return self
    }

    /**
     Resize will define the dimensions of the image.
     - parameter width: The width of the image
     - parameter height: The height of the image
     - returns: The builder
     */
    public func resize(width: CGFloat, height: CGFloat) -> Self {
      self.width = Int(width)
      self.height = Int(height)
      return self
    }

    /**
     Resize will define the dimensions of the image.
     - parameter size: The size of the image
     - returns: The builder
     */
    public func resize(size: CGSize) -> Self {
      self.width = Int(size.width)
      self.height = Int(size.height)
      return self
    }

    /**
     Horizontal and vertical align
     If the image is cropped to a different ratio and its margins needs trimming, horizontal and
     vertical align will specify which directions the cropping box will snap to.
     - parameter horizontal: Which horizontal portion should be kept
     - parameter vertical: Which vertical portion should be kept
     - returns: The builder
     */
    public func align(horizontal: HorizontalAlign, vertical: VerticalAlign) -> Self {
      self.hAlign = horizontal
      self.vAlign = vertical
      return self
    }

    /**
     Horizontal align
     If the image is cropped to a different ratio and its sides needs trimming, horizontal align
     will specify which direction the cropping box will snap to.
     - parameter horizontal: Which horizontal portion should be kept
     - returns: The builder
     */
    public func align(horizontal: HorizontalAlign) -> Self {
      self.hAlign = horizontal
      return self
    }

    /**
     Vertical align
     If the image is cropped to a different ratio and its margins needs trimming, vertical align
     will specify which direction the cropping box will snap to.
     - parameter vertical: Which vertical portion should be kept
     - returns: The builder
     */
    public func align(vertical: VerticalAlign) -> Self {
      self.vAlign = vertical
      return self
    }

    /**
     Smart detectors
     Enables the use of detectors. Detectors need to be enabled on the server as well.
     - parameter enabled: Whether smart detectors are enabled or not. Defaults to false if method is not called
     - returns: The builder
     */
    public func useSmartDetectors(_ enabled: Bool = true) -> Self {
      self.smartDetectors = enabled
      return self
    }

    /**
     Filter adds a filter to the list of processing filters.
     - parameter filter: A filter to be processed
     - returns: The builder
     */
    public func filter(_ filter: Filter) -> Self {
      filters.append(filter)
      return self
    }

    /**
     Generates the final URL String.
     - returns: The URL String to the processed image (or meta JSON)
     */
    public func toString() -> String {
      guard var host = Bumbo.host else {
        return "Bumbo: Thumbor host is not defined"
      }

      var thumborUrl = ""

      if meta {
        thumborUrl.append("meta/")
      }

      if trim != nil {
        thumborUrl.append("trim:\(trim!.rawValue)/")
      }

      if crop != nil {
        thumborUrl.append("\(crop!.leftTop.x)x\(crop!.leftTop.y):")
        thumborUrl.append("\(crop!.rightBottom.x)x\(crop!.rightBottom.y)/")
      }

      if fitIn {
        thumborUrl.append("fit-in/")
      }

      thumborUrl.append("\(width)x\(height)/")

      if hAlign != nil {
        thumborUrl.append("\(hAlign!)/")
      }

      if vAlign != nil {
        thumborUrl.append("\(vAlign!)/")
      }

      if smartDetectors {
        thumborUrl.append("smart/")
      }

      if filters.count > 0 {
        thumborUrl.append(concatFilters())
      }

      thumborUrl.append(sourceUrl)

      if !host.hasSuffix("/") {
        host = "\(host)/"
      }

      return host + (Bumbo.unsafe() ? "unsafe/\(thumborUrl)" : encrypt(url: thumborUrl))
    }

    /**
     Generates the final URL.
     - returns: The URL to the processed image (or meta JSON)
     */
    public func toURL() -> URL {
      return URL(string: toString())!
    }

    private func concatFilters() -> String {
      return filters.reduce("filters") { concat, filter in
        concat + ":" + filter.filterComponent
        } + "/"
    }

    private func encrypt(url: String) -> String {
      let bytes = Array(url.utf8)
      let signature = try! HMAC(key: Bumbo.secretKey!, variant: .sha1).authenticate(bytes)
      return signature.toBase64()!.urlSafe() + "/" + url
    }
  }
}
