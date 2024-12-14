import ProjectDescription

let project = Project(
    name: "githubClone",
    targets: [
        .target(
            name: "githubClone",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.githubClone",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
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
                .external(name: "Kingfisher"),
                .external(name: "Moya"),
                .external(name: "RxSwift"),
                .external(name: "RxDataSources"),
//                .external(name: "FlexLayout"),
                .external(name: "PinLayout"),
                .external(name: "ReactorKit")
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
