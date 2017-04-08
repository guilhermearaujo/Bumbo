# Bumbo
_A swifty client for [Thumbor](https://github.com/thumbor/thumbor)_

[![Version](https://img.shields.io/cocoapods/v/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)
[![License](https://img.shields.io/cocoapods/l/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)
[![Platform](https://img.shields.io/cocoapods/p/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)

## Installation

Bumbo is available through [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).
To install it, simply add the following line to your Podfile:

```ruby
pod 'Bumbo'
```

or in your Cartfile:

```ruby
github "guilhermearaujo/Bumbo"
```

## Usage

Configure your server and secret key:

```swift
Bumbo.configure(host: "https://thumbor.myurl.com/", secretKey: "MY_SECRET_KEY")
Bumbo.configure(host: "https://thumbor.myurl.com/", secretKey: nil) // Unsafe mode
```

Build your image URL with the desired settings and filters:

```swift
Bumbo.load("http://funnymemes.com/hilarious.jpg")
  .trim()
  .crop(leftTop: (x: 0, y: 0), rightBottom: (x: 200, y: 200))
  .fitIn()
  .resize(width: 320, height: 180)
  .align(horizontal: .left, vertical: .bottom)
  .useSmartDetectors()
  .filter(.grayScale)
  .filter(.stripICC)
  .filter(.rotate(90))
  .filter(.quality(50))
  .filter(.noise(50))
  .toUrl()
```

## License

Bumbo is available under the MIT license. See the LICENSE file for more info.
