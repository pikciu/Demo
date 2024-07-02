import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Resources",
    settings: .frameworkSettings,
    targets: [
        .target(
            name: "Resources",
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID("resources"),
            infoPlist: nil,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
//            scripts: [
//                .pre(tool: "swiftgen", arguments: [], name: "SwiftGen") // Strings catalogs not supported yet
//            ],
            dependencies: [
                
            ]
        )
    ]
)
