//
//  Filters.swift
//  Bumbo
//
//  Created by Guilherme Araújo on 15/03/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import Foundation

public extension Bumbo {
  public enum Filter {
    case backgroundColor(UIColor)
    case blur(radius: Float, sigma: Int)
    case brightness(Int)
    case contrast(Int)
    case convolution(matrix: [[Int]], normalize: Bool)
    case equalize
    case extractFocalPoints
    case filling(color: UIColor, fillTransparent: Bool)
    case focal(top: Int, left: Int, bottom: Int, right: Int)
    case format(Format)
    case grayScale
    case maxBytes(Int)
    case noUpscale
    case noise(Int)
    case quality(Int)
    case redEye
    case rgb(red: Int, green: Int, blue: Int)
    case rotate(Int)
    case roundCorners(Int)
    case sharpen(amount: Float, radius: Float, luminanceOnly: Bool)
    case stripICC
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
        return "format(\(format.rawValue))"
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
