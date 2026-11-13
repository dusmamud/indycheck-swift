// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IndyCheck",
    platforms: [
        .iOS(.v13),
        .macOS(.v11)
    ],
    products: [
        .library(name: "IndyCheck", targets: ["IndyCheck"])
    ],
    targets: [
        .binaryTarget(
            name: "IndyCheckFFI",
            url: "https://github.com/dusmamud/indycheck/releases/download/indycheck-v0.2.3/IndyCheckFFI.xcframework.zip",
            checksum: "165549626fb0618b81d3c9794ac1dec7076161a1dfcc5de5ec37ae81254d0def"
        ),
        .target(
            name: "IndyCheck",
            dependencies: ["IndyCheckFFI"],
            path: "Sources/IndyCheck"
        )
    ]
)
