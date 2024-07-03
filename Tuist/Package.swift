// swift-tools-version: 5.10
import PackageDescription

#if TUIST

    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings()

#endif

let package = Package(
    name: "DemoDependencies",
    dependencies: [
        .package(url: "https://github.com/pikciu/Container.git", from: "1.4.0"),
        .package(url: "https://github.com/pikciu/realm-swift.git", branch: "issue-8427/copy_seed_file_path"),
    ]
)
