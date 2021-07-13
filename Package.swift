// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Bumbo",
	products: [
		// Products define the executables and libraries a package produces, and make them visible to other packages.
		.library(
			name: "Bumbo",
			targets: ["Bumbo"]
		),
	],
	dependencies: [
		// Dependencies declare other packages that this package depends on.
		.package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.4.1"),
		.package(url: "https://github.com/Quick/Nimble.git", from: "9.2.0"),
		.package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
	],
	targets: [
		// Targets are the basic building blocks of a package. A target can define a module or a test suite.
		// Targets can depend on other targets in this package, and on products in packages this package depends on.
		.target(
			name: "Bumbo",
			dependencies: [
				"CryptoSwift",
			],
			exclude: [
				"PropertyList/Info.plist"
			]
		),
		.testTarget(
			name: "BumboTests",
			dependencies: [
				"Bumbo",
				"Nimble",
				"Quick",
			],
			exclude: [
				"PropertyList/Info.plist"
			]
		),
	]
)
