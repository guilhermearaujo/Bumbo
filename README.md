# Bumbo
_A swifty client for Thumbor_

[![Version](https://img.shields.io/cocoapods/v/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)
[![License](https://img.shields.io/cocoapods/l/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)
[![Platform](https://img.shields.io/cocoapods/p/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)

## Installation

Bumbo is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Bumbo'
```
## Usage

Configure your server and secret key:

```swift
Bumbo.configure(host: "https://thumbor.myurl.com/", secretKey: "MY_SECRET_KEY")
Bumbo.configure(host: "https://thumbor.myurl.com/", secretKey: nil) // Unsafe mode
```

Build your image with filters:

```swift
Bumbo.load("http://funnymemes.com/hilarious.jpg", width: 320, height: 180)
  .filter(.grayScale)
  .filter(.blur(radius: 3, sigma: 3))
  .filter(.stripICC)
  .filter(.roundCorners(8))
  .toUrl()
```

## License

Bumbo is available under the MIT license. See the LICENSE file for more info.
