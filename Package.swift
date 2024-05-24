// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coder",
    products: [
        .library(
            name: "Coder",
            targets: ["Coder"]),
        .library(
            name: "BinaryDecoder",
            targets: ["BinaryDecoder"]),
        .library(
            name: "BinaryEncoder",
            targets: ["BinaryEncoder"]),
        .library(
            name: "StringDecoder",
            targets: ["StringDecoder"]),
        .library(
            name: "StringEncoder",
            targets: ["StringEncoder"])
    ],
    dependencies: [
        .package(url: "git@github.com:spacenation/swift-binary.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "git@github.com:spacenation/swift-functional.git", .upToNextMajor(from: "0.1.0"))
    ],
    targets: [
        .target(
            name: "Coder",
            dependencies: [
                .product(name: "Binary", package: "swift-binary"),
                .product(name: "Functional", package: "swift-functional")
            ]
        ),
        .testTarget(
            name: "CoderTests",
            dependencies: ["Coder"]),
        
        /// Binary Decoder
        
        .target(
            name: "BinaryDecoder",
            dependencies: [
                "Coder",
                .product(name: "Binary", package: "swift-binary"),
                .product(name: "Functional", package: "swift-functional")
            ]
        ),
        .testTarget(name: "BinaryDecoderTests", dependencies: ["BinaryDecoder"]),
        
        /// Binary Encoder
        
        .target(
            name: "BinaryEncoder",
            dependencies: [
                "Coder",
                .product(name: "Binary", package: "swift-binary"),
                .product(name: "Functional", package: "swift-functional")
            ]
        ),
        .testTarget(
            name: "BinaryEncoderTests",
            dependencies: ["BinaryEncoder"]),
        
        /// String Decoder
        .target(
            name: "StringDecoder",
            dependencies: [
                "Coder",
                .product(name: "Functional", package: "swift-functional")
            ]
        ),
        .testTarget(
            name: "StringDecoderTests",
            dependencies: ["StringDecoder"]),
        
        /// String Encoder
        .target(
            name: "StringEncoder",
            dependencies: [
                "Coder",
                .product(name: "Functional", package: "swift-functional")
            ]
        ),
        .testTarget(
            name: "StringEncoderTests",
            dependencies: ["StringEncoder"]),
    ]
)
