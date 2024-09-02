// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkConnection",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "NetworkConnection",
            targets: ["NetworkConnection"]),
    ],

    targets: [
        .target(
            name: "NetworkConnection",
            resources: [],
            swiftSettings: [
                .enableUpcomingFeature("LibraryEvolution")
            ]
        ),

        .testTarget(
            name: "NetworkConnectionTests",
            dependencies: ["NetworkConnection"]),
    ],
    swiftLanguageVersions: [.v5]
)
