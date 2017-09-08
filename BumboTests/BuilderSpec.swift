//
//  BuilderSpec.swift
//  BumboTests
//
//  Created by Guilherme Araújo on 03/09/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

import Quick
import Nimble
@testable import Bumbo

class BuilderSpec: QuickSpec {
  // swiftlint:disable:next function_body_length
  override func spec() {
    let host = "http://host.com"
    let originalUrl = "http://test.url/image.jpg"

    beforeSuite {
      Bumbo.configure(host: host, secretKey: nil)
    }

    context("setting meta to true") {
      let subject = Bumbo.Builder(url: originalUrl).meta(true)

      it("should enable meta") {
        expect(subject.meta).to(beTrue())
      }

      it("should add '/meta' to the url") {
        let result = "\(host)/unsafe/meta/0x0/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting a corner to trim") {
      let subject = Bumbo.Builder(url: originalUrl).trim(.bottomRight)

      it("should add '/trim:[corner]' to the url") {
        let result = "\(host)/unsafe/trim:bottom-right/0x0/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting crop points") {
      let subject = Bumbo.Builder(url: originalUrl).crop(leftTop: (10, 20), rightBottom: (30, 40))

      it("should add '/LxT:RxB' offsets to the url") {
        let result = "\(host)/unsafe/10x20:30x40/0x0/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting fit-in to true") {
      let subject = Bumbo.Builder(url: originalUrl).fitIn(true)

      it("should enable fit-in") {
        expect(subject.fitIn).to(beTrue())
      }

      it("should add '/fit-in' to the url") {
        let result = "\(host)/unsafe/fit-in/0x0/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting resize dimensions with size") {
      let subject = Bumbo.Builder(url: originalUrl).resize(size: CGSize(width: 100, height: 200))

      it("should add '/WxH' to the url") {
        let result = "\(host)/unsafe/100x200/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting resize dimensions with width and height") {
      let subject = Bumbo.Builder(url: originalUrl).resize(width: 100, height: 200)

      it("should add '/WxH' to the url") {
        let result = "\(host)/unsafe/100x200/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting both align constraints") {
      let subject = Bumbo.Builder(url: originalUrl).align(horizontal: .left, vertical: .bottom)

      it("should add '/[horizontal/[vertical]' to the url") {
        let result = "\(host)/unsafe/0x0/left/bottom/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting horizontal align constraint") {
      let subject = Bumbo.Builder(url: originalUrl).align(horizontal: .left)

      it("should add '/[horizontal/[vertical]' to the url") {
        let result = "\(host)/unsafe/0x0/left/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting vertical align constraint") {
      let subject = Bumbo.Builder(url: originalUrl).align(vertical: .bottom)

      it("should add '/[horizontal/[vertical]' to the url") {
        let result = "\(host)/unsafe/0x0/bottom/smart/"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("setting smart detectors to false") {
      let subject = Bumbo.Builder(url: originalUrl).useSmartDetectors(false)

      it("should disable smart detectors") {
        expect(subject.smartDetectors).to(beFalse())
      }

      it("should not add '/smart' to the url") {
        expect(subject.toString()).notTo(contain("/smart"))
      }
    }

    context("adding a filter") {
      let subject = Bumbo.Builder(url: originalUrl).filter(.grayScale).filter(.stripICC)

      it("should add '/[filter]' to the url") {
        let result = "\(host)/unsafe/0x0/smart/filters:grayscale():strip_icc()"
        expect(subject.toString()).to(beginWith(result))
      }
    }

    context("building to URL") {
      let subject = Bumbo.Builder(url: originalUrl)

      it("should return a URL") {
        let result = URL(string: "\(host)/unsafe/0x0/smart/\(originalUrl)")!
        expect(subject.toURL()).to(equal(result))
      }
    }

    context("building to string") {
      let subject = Bumbo.Builder(url: originalUrl)

      it("should return a string") {
        let result = "\(host)/unsafe/0x0/smart/\(originalUrl)"
        expect(subject.toString()).to(equal(result))
      }
    }

    context("building with a secret key") {
      let subject = Bumbo.Builder(url: originalUrl)

      beforeEach {
        Bumbo.configure(host: host, secretKey: "OneTwoThree")
      }

      afterEach {
        Bumbo.configure(host: host, secretKey: nil)
      }

      it("should return a string with the validation hash") {
        let result = "\(host)/PdhDnpziuPv7iIpKdMBYzIwm8eQ=/0x0/smart/\(originalUrl)"
        expect(subject.toString()).to(equal(result))
      }
    }

    context("building without a host") {
      let subject = Bumbo.Builder(url: originalUrl)

      beforeEach {
        Bumbo.host = nil
      }

      it("should return an error message") {
        expect(subject.toString()).to(equal("Bumbo: Thumbor host is not defined"))
      }
    }
  }
}
