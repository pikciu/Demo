import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Domain",
    settings: .frameworkSettings,
    targets: [
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("domain"),
            infoPlist: nil,
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Container"),
                .project(target: "Resources", path: "../Resources")
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
                .target(name: "Domain")
            ]
        )
    ]
)
