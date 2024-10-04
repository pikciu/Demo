import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: .domain,
    packages: [
        Packages.swfitLint,
    ],
    settings: .frameworkSettings,
    targets: [
        .target(
            name: .domain,
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("domain"),
            infoPlist: nil,
            sources: .default,
            dependencies: [
                Dependencies.container,
                Dependencies.resources.project,
                Dependencies.swfitLint,
            ]
        ),
        .target(
            name: "DomainTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: .bundleID("domainTests"),
            infoPlist: nil,
            sources: ["Tests/**"],
            dependencies: [
                Dependencies.domain.target,
            ]
        ),
    ]
)
