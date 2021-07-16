# Bumbo
_A swifty client for [Thumbor](https://github.com/thumbor/thumbor)_

[![Version](https://img.shields.io/cocoapods/v/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)
[![Carthage compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)
[![Platform](https://img.shields.io/cocoapods/p/Bumbo.svg?style=flat)](http://cocoapods.org/pods/Bumbo)
![Build Status](https://github.com/guilhermearaujo/Bumbo/workflows/CI/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/63073700a6288733c82f/maintainability)](https://codeclimate.com/github/guilhermearaujo/Bumbo/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/63073700a6288733c82f/test_coverage)](https://codeclimate.com/github/guilhermearaujo/Bumbo/test_coverage)

## Installation

Bumbo is available through [CocoaPods](http://cocoapods.org), [Carthage](https://github.com/Carthage/Carthage) and [Swift Package Manager](https://swift.org/package-manager/).

### Cocoapods
To install it, simply add the following line to your Podfile:

```ruby
pod 'Bumbo'
```

### Carthage
or in your Cartfile:

```ruby
github "guilhermearaujo/Bumbo"
```

### Swift Package Manager

1. in xcode click file -> Swift Packages -> Add Swift Package Dependency
2. in the search bar, paste: `https://github.com/guilhermearaujo/Bumbo.git`
3. Once the package details load, select version `1.1.4`

OR if you are adding Bumbo to another swift package:

in your Package.swift file:

```swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "MyPackage",
	products: [
		.library(
			name: "MyPackage",
			targets: ["MyPackage"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/guilhermearaujo/Bumbo.git", from: "1.1.4"),
	],
	targets: [
		.target(
			name: "MyPackage",
			dependencies: [
				"Bumbo",
			],
		),
		.testTarget(
			name: "MyPackageTests",
			dependencies: [
				"MyPackage"
			],
		),
	]
)

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
  .toURL()
```

### Functions & filters
The [documentation](http://guilhermearaujo.dev/Bumbo/) provides a comprehensive list of [functions](http://guilhermearaujo.dev/Bumbo/Classes/Bumbo/Builder.html) and [filters](http://guilhermearaujo.dev/Bumbo/Classes/Bumbo/Filter.html) you can use to manipulate your images.

## License

Bumbo is available under the MIT license. See the [LICENSE](https://github.com/guilhermearaujo/Bumbo/blob/master/LICENSE) file for more info.
