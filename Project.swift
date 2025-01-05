import ProjectDescription

public enum ProjectDeployTarget: String {
    case dev = "DEV"
    case qa = "QA"
}

public extension ConfigurationName {
    static var dev: ConfigurationName { configuration(ProjectDeployTarget.dev.rawValue) }
    static var qa: ConfigurationName { configuration(ProjectDeployTarget.qa.rawValue) }
}

enum xcconfigFileRoot: Path {
    case debug = "githubClone/Config.xcconfig"
    case release = "githubClone/Config.release.xcconfig"
}

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

let project = Project(
    name: "githubClone",
    targets: [
        .target(
            name: "githubClone",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.githubClone",
            infoPlist: .extendingDefault(with: appInfoPlist),
            sources: ["githubClone/Sources/**"],
            resources: ["githubClone/Resources/**"],
            dependencies: commonDependencies,
            settings: Settings.settings(
                configurations: [
                    .debug(name: .debug, xcconfig: xcconfigFileRoot.debug.rawValue)
            ])
        ),
        .target(
            name: "release-gitHub",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.githubClone-release",
            infoPlist: .extendingDefault(with: appInfoPlist),
            sources: ["githubClone/Sources/**"],
            resources: ["githubClone/Resources/**"],
            dependencies: commonDependencies,
            settings: Settings.settings(
                configurations: [
                    .release(name: .release, xcconfig: xcconfigFileRoot.release.rawValue)
                ]
            )
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
)
