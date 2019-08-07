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
        .iOS(.v11),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v2),
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
