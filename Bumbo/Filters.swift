//
//  Filters.swift
//  Bumbo
//
//  Created by Guilherme Araújo on 15/03/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

public extension Bumbo {
  /**
   Available filters for processing

   Check [Thumbor's documentation](http://thumbor.readthedocs.io/en/latest/filters.html)
   for further explanation of each filter.
   */
  public enum Filter {
    /// Sets the background layer to the specified color
    case backgroundColor(UIColor)

    /// Applies Gaussian blur
    case blur(radius: Float, sigma: Int)

    /// Increases or decreases the image brightness
    ///
    /// Ranges from -100 to 100
    case brightness(Int)

    /// Increases or decreases the image contrast
    ///
    /// Ranges from -100 to 100
    case contrast(Int)

    /// Runs a convolution matrix (or kernel) on the image
    case convolution(matrix: [[Int]], normalize: Bool)

    /// Equalizes the color distribution in the image
    case equalize

    /// Use focal points when converting the image
    case extractFocalPoints

    /// Returns an image sized exactly as requested wherever is its ratio by
    /// filling with chosen color the missing parts. Usually used with `fit-in`
    case filling(color: UIColor, fillTransparent: Bool)

    /// Adds a focal point to be used in later transforms
    case focal(top: Int, left: Int, bottom: Int, right: Int)

    /// Specifies the output format of the image
    case format(Format)

    /// Converts the image to grayscale
    case grayScale

    /// Degrades the quality of the image until the image is under the
    /// specified amount of bytes
    case maxBytes(Int)

    /// Prevents thumbor from upscaling images
    case noUpscale

    /// Adds noise to the image
    case noise(Int)

    /// Changes the overall quality of the JPEG image (does nothing for PNGs
    /// or GIFs)
    ///
    /// Ranges from 0 to 100
    case quality(Int)

    ///
    case redEye

    /// Changes the amount of color in each of the three channels
    ///
    /// Channels range from -100 to 100
    case rgb(red: Int, green: Int, blue: Int)

    /// Rotates the image
    ///
    /// Angle ranges from 0 to 359
    case rotate(Int)

    /// Adds rounded corners to the image
    case roundCorners(Int)

    /// Enhances apparent sharpness of the image
    case sharpen(amount: Float, radius: Float, luminanceOnly: Bool)

    /// Removes any ICC information
    case stripICC

    /// Upscale
    ///
    /// This only makes sense with "fitIn"
    case upscale

    /// Adds a watermark image on top of the original
    case watermark(url: String, x: Int, y: Int, alpha: Int)

    var filterComponent: String {
      switch self {
      case .backgroundColor(let color):
        return "background_color(\(color.hexColor))"
      case .blur(let radius, let sigma):
        return "blur(\(radius),\(sigma))"
      case .brightness(let amount):
        return "brightness(\(amount))"
      case .contrast(let amount):
        return "contrast(\(amount))"
      case .convolution(let matrix, let normalize):
        return "convolution(\(reduceMatrix(matrix)),\(matrix.first?.count ?? 0),\(normalize))"
      case .equalize:
        return "equalize()"
      case .extractFocalPoints:
        return "extract_focal()"
      case .filling(let color, let fillTransparent):
        return "filling(\(color.hexColor),\(fillTransparent))"
      case .focal(let top, let left, let bottom, let right):
        return "focal(\(left)x\(top),\(right)x\(bottom))"
      case .format(let format):
        return "format(\(format))"
      case .grayScale:
        return "grayscale()"
      case .maxBytes(let size):
        return "max_bytes(\(size))"
      case .noUpscale:
        return "no_upscale()"
      case .noise(let amount):
        return "noise(\(amount))"
      case .quality(let quality):
        return "quality(\(quality))"
      case .redEye:
        return "red_eye()"
      case .rgb(let red, let green, let blue):
        return "rgb(\(red),\(green),\(blue))"
      case .rotate(let angle):
        return "rotate(\(angle))"
      case .roundCorners(let radius):
        return "round_corner(\(radius))"
      case .sharpen(let amount, let radius, let luminanceOnly):
        return "sharpen(\(amount),\(radius),\(luminanceOnly))"
      case .stripICC:
        return "strip_icc()"
      case .upscale:
        return "upscale()"
      case .watermark(let url, let x, let y, let alpha):
        return "watermark(\(url),\(x),\(y),\(alpha))"
      }
    }

    private func reduceMatrix(_ matrix: [[Int]]) -> String {
      return matrix.joined()
        .map { String($0) }
        .joined(separator: ";")
    }
  }
}
