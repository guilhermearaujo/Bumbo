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
    var url: String = ""
    var width: Int = 0
    var height: Int = 0
    var filters: [Filter] = []

    init(url: String, width: Int, height: Int) {
      self.url = url
      self.width = width
      self.height = height
    }

    public func filter(_ filter: Filter) -> Self {
      filters.append(filter)
      return self
    }

    public func toUrl() -> String {
      guard let host = Bumbo.host else {
        return "Bumbo: Thumbor host is not defined"
      }

      let baseUrl = "\(width)x\(height)/" + (concatFilters() ?? "") + url

      return host + (Bumbo.unsafe() ? "unsafe/\(baseUrl)" : encrypt(url: baseUrl))
    }

    private func concatFilters() -> String? {
      if filters.count == 0 { return nil }

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
