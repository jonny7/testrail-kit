// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "testrail-kit",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "TestRailKit", targets: ["TestRailKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", .upToNextMajor(from: "2.20.2")),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.1.0")
    ],
    targets: [
        .target(name: "TestRailKit", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client")
        ]),
        .testTarget(name: "TestRailKitTests", dependencies: [
            .target(name: "TestRailKit"),
            .product(name: "NIOTestUtils", package: "swift-nio"),
        ])
    ]
)
