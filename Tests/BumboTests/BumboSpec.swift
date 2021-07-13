//
//  BumboSpec.swift
//  BumboTests
//
//  Created by Guilherme Araújo on 07/09/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

import Quick
import Nimble
@testable import Bumbo

class BumboSpec: QuickSpec {
  override func spec() {
    context("load") {
      it("should return a Builder") {
        expect(Bumbo.load("some url")).to(beAKindOf(Bumbo.Builder.self))
      }
    }
  }
}
