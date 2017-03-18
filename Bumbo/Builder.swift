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

    init(url: String, width: Int, height: Int) {
      self.sourceUrl = url
      self.width = width
      self.height = height
    }

    public func meta(_ enabled: Bool = true) -> Self {
      self.meta = enabled
      return self
    }

    public func trim(_ corner: TrimCorner = .topLeft) -> Self {
      self.trim = corner
      return self
    }

    public func crop(leftTop: (x: Int, y: Int), rightBottom: (x: Int, y: Int)) -> Self {
      self.crop = (leftTop, rightBottom)
      return self
    }

    public func fitIn(_ enabled: Bool = true) -> Self {
      self.fitIn = enabled
      return self
    }

    public func align(horizontal: HorizontalAlign, vertical: VerticalAlign) -> Self {
      self.hAlign = horizontal
      self.vAlign = vertical
      return self
    }

    public func align(horizontal: HorizontalAlign) -> Self {
      self.hAlign = horizontal
      return self
    }

    public func align(vertical: VerticalAlign) -> Self {
      self.vAlign = vertical
      return self
    }

    public func useSmartDetectors(_ enabled: Bool = true) -> Self {
      self.smartDetectors = enabled
      return self
    }

    public func filter(_ filter: Filter) -> Self {
      filters.append(filter)
      return self
    }

    public func toUrl() -> String {
      guard let host = Bumbo.host else {
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

      return host + (Bumbo.unsafe() ? "unsafe/\(thumborUrl)" : encrypt(url: thumborUrl))
    }

    private func concatFilters() -> String {
      if filters.count == 0 { return "" }

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
