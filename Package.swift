// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-coreimage",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        // CoreImageUtils

        .library(
            name: "CoreImageFilters",
            targets: ["CoreImageFilters"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CoreImageFilters"
        ),
        .testTarget(
            name: "CoreImageFiltersTests",
            dependencies: ["CoreImageFilters"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
