// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
//            "FlexLayout" : .framework,
//            "PinLayout" : .framework,
//            "SwiftLint" : .framework,
//            "RxSwift" : .framework,
//            "RxDataSource" : .framework,
//            "Moya" : .framework,
//            "ReactorKit" : .framework,
//            "Kingfisher" : .framework
            :
        ]
    )
#endif

let package = Package(
    name: "githubClone",
    dependencies: [
        .package(url: "https://github.com/layoutBox/FlexLayout", from: "1.3.18"),
        .package(url: "https://github.com/layoutBox/PinLayout", from: "1.10.5"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", from: "5.0.0"),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "8.1.2"))
    ]
)
