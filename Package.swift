// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "fonts",
    platforms:
    [
        .macOS(.v14)
    ],
    products:
    [
        .library(
            name: "Fonts",
            targets:
            [
                "Fonts"
            ]
        )
    ],
    targets:
    [
        .target(
            name: "Fonts"
        ),
        .testTarget(
            name: "FontsTests",
            dependencies:
            [
                "Fonts"
            ]
        )
    ]
)
