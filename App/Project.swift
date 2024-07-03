import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "App",
    options: .options(defaultKnownRegions: ["en", "pl"]),
    packages: [
        Plugins.Packages.swfitLint,
    ],
    settings: .settings(base: ["GENERATE_INFOPLIST_FILE": "YES"]),
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: .bundleID("app"),
            infoPlist: .file(path: "App-Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Data", path: "../Data"),
                .project(target: "Domain", path: "../Domain"),
                .project(target: "HTTP", path: "../HTTP"),
                Plugins.Dependencies.swfitLint,
            ],
            settings: .settings(
                base: [
                    "INFOPLIST_KEY_UILaunchScreen_Generation": "YES",
                    "GENERATE_INFOPLIST_FILE": "NO",
                ],
                configurations: [
                    .debug(name: "Debug", xcconfig: "App.xcconfig"),
                    .release(name: "Release", xcconfig: "App.xcconfig"),
                ]
            )
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: .bundleID("appTests"),
            infoPlist: nil,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "App"),
            ]
        ),
        .target(
            name: "AppUITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: .bundleID("appUITests"),
            infoPlist: nil,
            sources: ["UITests/**"],
            dependencies: [
                .target(name: "App"),
            ]
        ),
    ]
)
