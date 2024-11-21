// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package: Package = Package(
    name: "NetworkProvider",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "NetworkProvider",
            targets: ["NetworkProvider"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: ("5.4.3"))),
        .package(url: "https://github.com/ashleymills/Reachability.swift", .upToNextMajor(from: "5.1.0"))
    ],
    targets: [
        .target(
            name: "NetworkProvider",
            dependencies: [
                "Alamofire",
                "Reachability",
            ],
            path: "NetworkProvider"),
        .testTarget(
            name: "NetworkProviderTests",
            dependencies: ["NetworkProvider"],
            path: "NetworkProviderTests")
    ]
)
