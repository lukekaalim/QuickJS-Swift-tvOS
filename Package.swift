// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuickJS",
    platforms: [
        .tvOS(.v11),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "QuickJS",
            targets: ["QuickJS"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "QuickJSC",
            dependencies: [],
            path: "Sources/QuickJSC",
            sources: [
                "include",
                "mirror/cutils.h",
                "mirror/cutils.c",
                "mirror/libunicode.h",
                "mirror/libunicode.c",
                "mirror/libregexp.h",
                "mirror/libregexp.c",
                "mirror/quickjs.h",
                "mirror/quickjs.c"
            ], 
            cSettings: [
                .define("CONFIG_VERSION", to: "\"Custom Swift Build\"")
            ]
        ),
        .target(
            name: "QuickJS",
            dependencies: ["QuickJSC"]),
        .testTarget(
            name: "QuickJSTests",
            dependencies: ["QuickJS"]),
    ]
)
