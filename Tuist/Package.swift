// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

#endif

let package = Package(
    name: "DemoDependencies",
    dependencies: [
        .package(url: "https://github.com/pikciu/Container.git", from: "1.4.0"),
    ]
)
