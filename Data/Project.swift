import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: .data,
    packages: [
        Packages.swfitLint,
    ],
    settings: .frameworkSettings,
    targets: [
        .target(
            name: .data,
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("data"),
            infoPlist: nil,
            sources: .default,
            resources: .default,
            dependencies: [
                Dependencies.domain.project,
                Dependencies.http.project,
                Dependencies.realmSwift,
                Dependencies.realm,
                Dependencies.swfitLint,
            ]
        ),
        .target(
            name: "DataTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: .bundleID("dataTests"),
            infoPlist: nil,
            sources: ["Tests/**"],
            dependencies: [
                Dependencies.data.target
            ]
        ),
    ]
)
