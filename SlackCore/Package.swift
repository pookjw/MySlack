// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SlackCore",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "SlackCore",
            targets: ["SlackCore"]
        )
    ], 
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-testing.git", branch: "main"),
//        .package(url: "https://github.com/apple/swift-foundation.git", branch: "main"),
//        .package(path: "../../my-swift-foundation"),
        .package(url: "https://github.com/apple/swift-nio.git", branch: "main")
    ],
    targets: [
        .target(
            name: "SlackCore",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
//                .product(name: "FoundationPreview", package: "my-swift-foundation"),
                .product(name: "_NIOFileSystem", package: "swift-nio")
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx),
                .enableExperimentalFeature("RawLayout")
            ]
        ),
        .testTarget(
            name: "SlackCoreTests",
            dependencies: [
                .byName(name: "SlackCore"),
                .product(name: "Testing", package: "swift-testing")
            ],
            swiftSettings: [
                .interoperabilityMode(.Cxx)
            ]
        )
    ]
)
