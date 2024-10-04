import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: .http,
    packages: [
        Packages.swfitLint,
    ],
    settings: .frameworkSettings,
    targets: [
        .target(
            name: .http,
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("http"),
            infoPlist: nil,
            sources: .default,
            dependencies: [
                Dependencies.swfitLint,
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
                Dependencies.http.target,
                Dependencies.swfitLint,
            ]
        ),
    ]
)
