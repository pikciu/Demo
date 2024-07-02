import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "HTTP",
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
                .target(name: "HTTP")
            ]
        )
    ]
)
