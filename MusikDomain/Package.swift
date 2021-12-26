// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MusikDomain",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MusikNetworking",
            targets: ["MusikNetworking"]),
        .library(
            name: "MusikCommonUI",
            targets: ["MusikCommonUI"]),
    ],
    dependencies: [
        .package(name: "ABNetworking",
                 url: "https://github.com/alessioborraccino/abnetworking.git",
                 .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/JanGorman/Hippolyte.git",
                 .exact("1.4.0"))
    ],
    targets: [
        .target(
            name: "MusikNetworking",
            dependencies: ["ABNetworking"],
            path: "Sources/Networking"),
        .testTarget(name: "MusikNetworkingTests",
                    dependencies: ["MusikNetworking","Hippolyte"],
                    path: "Tests/Networking"),
        .target(
            name: "MusikCommonUI",
            dependencies: [],
            path: "Sources/CommonUI")
    ]
)
