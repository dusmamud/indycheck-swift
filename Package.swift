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
            url: "https://github.com/dusmamud/indycheck/releases/download/indycheck-v0.2.4/IndyCheckFFI.xcframework.zip",
            checksum: "a85564ff3d02b0e5d2c9bfd5bf00da8327e778e3adbb679dff15576db7a64d8a"
        ),
        .target(
            name: "IndyCheck",
            dependencies: ["IndyCheckFFI"],
            path: "Sources/IndyCheck"
        )
    ]
)
