// swift-tools-version:5.0
//
//  STPhotoCollection.swift
//  STPhotoCollection
//
//  Created by Streetography on 01/04/19.
//  Copyright © 2019 mikelanza. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "STPhotoCollection",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "STPhotoCollection",
            targets: ["STPhotoCollection"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/mikelanza/st-photo-core-ios.git", .upToNextMajor(from: "0.1.4"))
    ],
    targets: [
        .target(
            name: "STPhotoCollection",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "STPhotoCollectionTests",
            dependencies: ["STPhotoCollection"],
            path: "Tests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
