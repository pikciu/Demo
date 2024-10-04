import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: .app,
    options: .options(
        automaticSchemesOptions: .disabled,
        defaultKnownRegions: ["Base", "en", "pl"]
    ),
    packages: [
        Packages.swfitLint,
    ],
    settings: .settings(
        base: ["GENERATE_INFOPLIST_FILE": "YES"],
        configurations: [
            .debug(name: "Debug", xcconfig: "App.xcconfig"),
            .release(name: "Release", xcconfig: "App.xcconfig"),
        ]
    ),
    targets: [
        .target(
            name: .app,
            destinations: .iOS,
            product: .app,
            bundleId: .bundleID("app"),
            infoPlist: .file(path: "App-Info.plist"),
            sources: .default,
            resources: .default,
            dependencies: [
                Dependencies.data.project,
                Dependencies.domain.project,
                Dependencies.http.project,
                Dependencies.utils,
                Dependencies.swfitLint,
            ],
            settings: .settings(
                base: [
                    "INFOPLIST_KEY_UILaunchScreen_Generation": "YES",
                    "GENERATE_INFOPLIST_FILE": "NO",
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
                Dependencies.app.target
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
                Dependencies.app.target
            ]
        ),
    ],
    schemes: []
)
