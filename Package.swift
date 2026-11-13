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
            url: "https://github.com/dusmamud/indycheck/releases/download/indycheck-v0.2.5/IndyCheckFFI.xcframework.zip",
            checksum: "deb7060b5d71381bd0b125b0d62e11af140b240dd99642f47073cf3e353c1650"
        ),
        .target(
            name: "IndyCheck",
            dependencies: ["IndyCheckFFI"],
            path: "Sources/IndyCheck"
        )
    ]
)
