import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Data",
    packages: [
        .package(url: "https://github.com/pikciu/realm-swift.git", .branch("issue-8427/copy_seed_file_path")),
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
                .package(product: "RealmSwift"),
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
                .target(name: "Data")
            ]
        )
    ]
)
