//
//  FiltersSpec.swift
//  BumboTests
//
//  Created by Guilherme Araújo on 07/09/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

import Quick
import Nimble
@testable import Bumbo

class FiltersSpec: QuickSpec {
  // swiftlint:disable:next function_body_length
  override func spec() {
    context("background color") {
      let filter = Bumbo.Filter.backgroundColor(UIColor.red)

      it("component") {
        expect(filter.filterComponent).to(equal("background_color(ff0000)"))
      }
    }

    context("blur") {
      let filter = Bumbo.Filter.blur(radius: 5.5, sigma: 2)

      it("component") {
        expect(filter.filterComponent).to(equal("blur(5.5,2)"))
      }
    }

    context("brightness") {
      let filter = Bumbo.Filter.brightness(10)

      it("component") {
        expect(filter.filterComponent).to(equal("brightness(10)"))
      }
    }

    context("contrast") {
      let filter = Bumbo.Filter.contrast(10)

      it("component") {
        expect(filter.filterComponent).to(equal("contrast(10)"))
      }
    }

    context("convolution") {
      context("valid matrix") {
        let filter = Bumbo.Filter.convolution(matrix: [[1, 2, 1], [2, 4, 2], [2, 1, 2]], normalize: true)

        it("component") {
          expect(filter.filterComponent).to(equal("convolution(1;2;1;2;4;2;2;1;2,3,true)"))
        }
      }

      context("empty matrix") {
        let filter = Bumbo.Filter.convolution(matrix: [[]], normalize: true)

        it("component") {
          expect(filter.filterComponent).to(equal(""))
        }
      }

      context("non-square matrices") {
        let matrices = [
          [[1, 2, 1], [2, 4, 2]],
          [[1, 2, 1], [2, 4, 2], [2, 1]]
        ]

        matrices.forEach { matrix in
          let filter = Bumbo.Filter.convolution(matrix: matrix, normalize: true)

          it("component") {
            expect(filter.filterComponent).to(equal(""))
          }
        }
      }
    }

    context("equalize") {
      let filter = Bumbo.Filter.equalize

      it("component") {
        expect(filter.filterComponent).to(equal("equalize()"))
      }
    }

    context("extract focal points") {
      let filter = Bumbo.Filter.extractFocalPoints

      it("component") {
        expect(filter.filterComponent).to(equal("extract_focal()"))
      }
    }

    context("filling") {
      let filter = Bumbo.Filter.filling(color: UIColor.green, fillTransparent: true)

      it("component") {
        expect(filter.filterComponent).to(equal("fill(00ff00,true)"))
      }
    }

    context("focal") {
      let filter = Bumbo.Filter.focal(top: 1, left: 2, bottom: 3, right: 4)

      it("component") {
        expect(filter.filterComponent).to(equal("focal(2x1,4x3)"))
      }
    }

    context("format") {
      let filter = Bumbo.Filter.format(.png)

      it("component") {
        expect(filter.filterComponent).to(equal("format(png)"))
      }
    }

    context("gray scale") {
      let filter = Bumbo.Filter.grayScale

      it("component") {
        expect(filter.filterComponent).to(equal("grayscale()"))
      }
    }

    context("max bytes") {
      let filter = Bumbo.Filter.maxBytes(300)

      it("component") {
        expect(filter.filterComponent).to(equal("max_bytes(300)"))
      }
    }

    context("no upscale") {
      let filter = Bumbo.Filter.noUpscale

      it("component") {
        expect(filter.filterComponent).to(equal("no_upscale()"))
      }
    }

    context("noise") {
      let filter = Bumbo.Filter.noise(20)

      it("component") {
        expect(filter.filterComponent).to(equal("noise(20)"))
      }
    }

    context("proportion") {
      let filter = Bumbo.Filter.proportion(0.4)

      it("component") {
        expect(filter.filterComponent).to(equal("proportion(0.4)"))
      }
    }

    context("quality") {
      let filter = Bumbo.Filter.quality(100)

      it("component") {
        expect(filter.filterComponent).to(equal("quality(100)"))
      }
    }

    context("red eye") {
      let filter = Bumbo.Filter.redEye

      it("component") {
        expect(filter.filterComponent).to(equal("red_eye()"))
      }
    }

    context("rgb") {
      let filter = Bumbo.Filter.rgb(red: 20, green: 40, blue: 60)

      it("component") {
        expect(filter.filterComponent).to(equal("rgb(20,40,60)"))
      }
    }

    context("rotate") {
      let filter = Bumbo.Filter.rotate(90)

      it("component") {
        expect(filter.filterComponent).to(equal("rotate(90)"))
      }
    }

    context("round corners") {
      let filter = Bumbo.Filter.roundCorners(25)

      it("component") {
        expect(filter.filterComponent).to(equal("round_corner(25)"))
      }
    }

    context("sharpen") {
      let filter = Bumbo.Filter.sharpen(amount: 10, radius: 5, luminanceOnly: false)

      it("component") {
        expect(filter.filterComponent).to(equal("sharpen(10.0,5.0,false)"))
      }
    }

    context("stretch") {
      let filter = Bumbo.Filter.stretch

      it("component") {
        expect(filter.filterComponent).to(equal("stretch()"))
      }
    }

    context("strip EXIF") {
      let filter = Bumbo.Filter.stripEXIF

      it("component") {
        expect(filter.filterComponent).to(equal("strip_exif()"))
      }
    }

    context("strip ICC") {
      let filter = Bumbo.Filter.stripICC

      it("component") {
        expect(filter.filterComponent).to(equal("strip_icc()"))
      }
    }

    context("upscale") {
      let filter = Bumbo.Filter.upscale

      it("component") {
        expect(filter.filterComponent).to(equal("upscale()"))
      }
    }

    context("watermark") {
      context("no ratio") {
        let filter = Bumbo.Filter.watermark(url: "url", x: 10, y: 20, alpha: 30, widthRatio: nil, heightRatio: nil)

        it("component") {
          expect(filter.filterComponent).to(equal("watermark(url,10,20,30,none,none)"))
        }
      }

      context("width ratio only") {
        let filter = Bumbo.Filter.watermark(url: "url", x: 10, y: 20, alpha: 30, widthRatio: 0.3, heightRatio: nil)

        it("component") {
          expect(filter.filterComponent).to(equal("watermark(url,10,20,30,0.3,none)"))
        }
      }

      context("height ratio only") {
        let filter = Bumbo.Filter.watermark(url: "url", x: 10, y: 20, alpha: 30, widthRatio: nil, heightRatio: 0.5)

        it("component") {
          expect(filter.filterComponent).to(equal("watermark(url,10,20,30,none,0.5)"))
        }
      }

      context("both ratios") {
        let filter = Bumbo.Filter.watermark(url: "url", x: 10, y: 20, alpha: 30, widthRatio: 0.3, heightRatio: 0.5)

        it("component") {
          expect(filter.filterComponent).to(equal("watermark(url,10,20,30,0.3,0.5)"))
        }
      }
    }
  }
}
