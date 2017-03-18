//
//  ViewController.swift
//  Example
//
//  Created by Guilherme Araújo on 17/03/17.
//  Copyright © 2017 Guilherme Araújo. All rights reserved.
//

import UIKit
import Bumbo

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    Bumbo.configure(host: "http://192.168.10.24:8888/", secretKey: "my_secret_key")

    let width = Int((0.5 + Float(arc4random_uniform(2))) * 400)
    let height = Int((0.5 + Float(arc4random_uniform(2))) * 400)

    let url = Bumbo.load("lorempixel.com/\(width)/\(height)", width: 320, height: 320)
      .trim()
      .crop(leftTop: (x: 0, y: 0), rightBottom: (x: 200, y: 200))
      .fitIn()
      .align(horizontal: .left, vertical: .bottom)
      .useSmartDetectors()
      .filter(.grayScale)
      .filter(.stripICC)
      .filter(.rotate(90))
      .filter(.quality(50))
      .filter(.noise(50))
      .toUrl()

    print(url)

    let imageView = UIImageView(frame: view.frame)
    imageView.contentMode = UIViewContentMode.center
    view.addSubview(imageView)

    let data = try! Data(contentsOf: URL(string: url)!)
    imageView.image = UIImage(data: data)
  }
}

