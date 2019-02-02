// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Nest",
    dependencies: [
//        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
      .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        //.Package(url: "https://github.com/qutheory/vapor-mustache.git", majorVersion: 0, minor: 10),
//        .Package(url: "https://github.com/matthijs2704/vapor-apns.git", majorVersion: 1, minor: 2),
//        .Package(url: "https://github.com/OpenKitten/MainecoonVapor.git", majorVersion: 0, minor: 1),
//        .Package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver-Vapor.git", majorVersion: 1),
//        .Package(url: "https://github.com/vapor/postgresql-provider", majorVersion: 1, minor: 1)
    ]
)

/*
 exclude: [
 "Config",
 "Database",
 "Localization",
 "Public",
 "Resources",
 ],
 */
