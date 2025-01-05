// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
    productTypes: [
        "RxSwift" : .framework,
        "RxDataSource" : .framework,
        "Moya" : .framework,
        "Then" : .framework,
        "SnapKit" : .framework,
        "RxCocoa" : .framework,
        "RxCocoaRuntime" : .framework,
        "RxRelay" : .framework
    ],
    baseSettings: .settings(
        configurations: [
            .debug(name: .debug),
            .release(name: .release),
        ])
)
#endif

let package = Package(
    name: "githubClone",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.8.0"),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", from: "5.0.2"),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.3")),
        .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1")
    ]
)
