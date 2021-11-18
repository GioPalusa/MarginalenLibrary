// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MarginalenLibrary",
	platforms: [
		.iOS(.v14)
	],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MarginalenLibrary",
            targets: ["MarginalenLibrary"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
		.package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", .branch("master")),
		.package(name: "Lottie", url: "https://github.com/airbnb/lottie-ios.git", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MarginalenLibrary",
            dependencies: [
				.product(name: "FirebaseAnalytics", package: "Firebase"),
				.product(name: "Lottie", package: "Lottie")
			],
			resources: [
				.process("Assets/LottieFiles/ballAnimation.json"),
				.process("Assets/LottieFiles/infinite.json"),
				.process("Assets/Fonts/Sohne-Buch.otf")]),
        .testTarget(
            name: "MarginalenLibraryTests",
            dependencies: ["MarginalenLibrary"]),
    ]
)

