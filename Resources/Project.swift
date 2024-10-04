import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: .resources,
    packages: [
        Packages.swfitLint,
    ],
    settings: .frameworkSettings,
    targets: [
        .target(
            name: .resources,
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("resources"),
            infoPlist: nil,
            sources: .default,
            resources: .default,
            dependencies: []
        ),
    ]
)
