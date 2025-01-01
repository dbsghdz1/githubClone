import ProjectDescription

let settings = Settings.settings(
    configurations: [
        .debug(name: "Debug", xcconfig: "githubClone/Config.xcconfig")
    ]
)


let project = Project(
    name: "githubClone",
    settings: settings,
    targets: [
        .target(
            name: "githubClone",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.githubClone",
            infoPlist: .extendingDefault(
                with: [
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
                    ],
                ]
            ),
            sources: ["githubClone/Sources/**"],
            resources: ["githubClone/Resources/**"],
            dependencies: [
                .external(name: "Moya"),
                .external(name: "RxSwift"),
                .external(name: "RxDataSources"),
                .external(name: "Then"),
                .external(name: "SnapKit"),
                .external(name: "RxMoya"),
                .external(name: "RxCocoa"),
            ]
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
