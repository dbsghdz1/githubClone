import ProjectDescription

let commonDependencies: [TargetDependency] = [
    .external(name: "Moya"),
    .external(name: "RxSwift"),
    .external(name: "RxDataSources"),
    .external(name: "Then"),
    .external(name: "SnapKit"),
    .external(name: "RxMoya"),
    .external(name: "RxCocoa")
]

let appInfoPlist: [String : Plist.Value] = [
    "CFBundleURLTypes": [
        [
            "CFBundleURLName": "URL Types",
            "CFBundleURLSchemes": ["githubClone"]
        ]
    ],
    "UILaunchStoryboardName": "LaunchScreen.storyboard",
    "CLIENT_ID": "$(CLIENT_ID)",
    "CLIENT_ID_SECRET": "$(CLIENT_ID_SECRET)",
    "UIApplicationSceneManifest": [
        "UIApplicationSupportsMultipleScenes": false,
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [
                [
                    "UISceneConfigurationName": "Default Configuration",
                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                ],
            ]
        ]
    ]
]
let targets: [Target] = [
        .target(
            name: "githubClone",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.githubClone",
            infoPlist: .extendingDefault(with: appInfoPlist),
            sources: ["githubClone/Sources/**"],
            resources: ["githubClone/Resources/**"],
            dependencies: commonDependencies
        ),
        .target(
            name: "githubCloneTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.githubCloneTests",
            infoPlist: .default,
            sources: ["githubClone/Tests/**"],
            resources: [],
            dependencies: [.target(name: "githubClone")]
        ),
    ]

let project = Project.makeApp(name: "githubClone", target: targets)

extension Project {
    public static func makeApp(name: String, target: [Target]) -> Project {
        return Project(
            name: name,
            settings: .settings(
                configurations: [
                    .build(.dev, name: name),
                    .build(.prd, name: name)
                ]
            ),
            targets: target,
            schemes: [
                .makeScheme(.dev, name: name),
                .makeScheme(.prd, name: name)
            ],
            additionalFiles: [
                "./githubClone/XCConfig/XCConfig.shared.xcconfig"
            ]
        )
    }
}

extension ProjectDescription.Configuration {
    public static func build(_ type: BuildTarget, name: String = "") -> Self {
        let buildName = type.rawValue
        switch type {
        case .dev:
            return .debug(
                name: BuildTarget.dev.configurationName,
                xcconfig: .relativeToXCConfig(type: .dev)
            )
        case .prd:
            return .release(
                name: BuildTarget.prd.configurationName,
                xcconfig: .relativeToXCConfig(type: .prd)
            
            )
        }
    }
}

extension Scheme {
    
    public static func makeScheme(_ type: BuildTarget, name: String) -> Self {
        let buildName = type.rawValue
        switch type {
            case .dev:
                return .scheme(
                    name: "\(name)-\(buildName.uppercased())",
                    buildAction: .buildAction(targets: ["\(name)"]),
                    runAction: .runAction(configuration: type.configurationName),
                    archiveAction: .archiveAction(configuration: type.configurationName),
                    profileAction: .profileAction(configuration: type.configurationName),
                    analyzeAction: .analyzeAction(configuration: type.configurationName)
                )
            case .prd:
                return .scheme(
                    name: "\(name)-\(buildName.uppercased())",
                    buildAction: .buildAction(targets: ["\(name)"]),
                    runAction: .runAction(configuration: type.configurationName),
                    archiveAction: .archiveAction(configuration: type.configurationName),
                    profileAction: .profileAction(configuration: type.configurationName),
                    analyzeAction: .analyzeAction(configuration: type.configurationName)
                )
        }
    }
}

public enum BuildTarget: String {
    case dev = "debug"
    case prd = "release"
    
    public var configurationName: ConfigurationName {
        return ConfigurationName.configuration(self.rawValue)
    }
}

extension Path {
    public static func relativeToXCConfig(type: BuildTarget) -> Self {
        return .relativeToRoot("./githubClone/XCConfig/XCConfig.\(type.rawValue.lowercased()).xcconfig")
    }
}
