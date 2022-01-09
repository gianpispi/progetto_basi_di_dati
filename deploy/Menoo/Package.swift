// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "menoo",
    platforms: [
       .macOS(.v10_11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(name: "menoo", targets: ["menoo"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "0.4.4")),
        .package(url: "https://github.com/codewinsdotcom/PostgresClientKit", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/onevcat/Rainbow.git", .upToNextMinor(from: "3.2.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "menoo",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "PostgresClientKit", package: "PostgresClientKit"),
                .product(name: "Rainbow", package: "Rainbow"),
            ]),
        .testTarget(
            name: "MenooTests",
            dependencies: ["menoo"]),
    ]
)
