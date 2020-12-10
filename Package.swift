// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SwiftUIExtensions",
    platforms: [.iOS(.v14), .tvOS(.v14), .watchOS(.v7), .macOS(.v11)],
    products: [
        .library(
            name: "SwiftUIExtensions",
            targets: ["SwiftUIExtensions"]),
    ],
    targets: [
        .target(
            name: "SwiftUIExtensions",
            dependencies: []),
        .testTarget(
            name: "SwiftUIExtensionsTests",
            dependencies: ["SwiftUIExtensions"]),
    ]
)
