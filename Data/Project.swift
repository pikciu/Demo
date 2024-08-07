import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    packages: [
        Plugins.Packages.swfitLint,
    ],
    settings: .frameworkSettings,
    targets: [
        .target(
            name: "Data",
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("data"),
            infoPlist: nil,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Domain", path: "../Domain"),
                .project(target: "HTTP", path: "../HTTP"),
                .external(name: "RealmSwift"),
                Plugins.Dependencies.swfitLint,
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
                .target(name: "Data"),
            ]
        ),
    ]
)
