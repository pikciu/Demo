import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HTTP",
    packages: [
        Plugins.Packages.swfitLint,
    ],
    settings: .frameworkSettings,
    targets: [
        .target(
            name: "HTTP",
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("http"),
            infoPlist: nil,
            sources: ["Sources/**"],
            dependencies: [
                Plugins.Dependencies.swfitLint,
            ]
        ),
        .target(
            name: "HTTPTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: .bundleID("httpTests"),
            infoPlist: nil,
            sources: ["Tests/**"],
            dependencies: [
                .target(name: "HTTP"),
                Plugins.Dependencies.swfitLint,
            ]
        ),
    ]
)
