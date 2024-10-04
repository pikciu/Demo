// swift-tools-version: 5.10
@preconcurrency import PackageDescription

#if TUIST

@preconcurrency import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings()

#endif

let package = Package(
    name: "DemoDependencies",
    dependencies: [
        .package(url: "https://github.com/pikciu/Container.git", from: "1.4.0"),
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.54.0"),
        .package(url: "https://github.com/pikciu/SwiftUI-Utils.git", from: "1.0.4")
    ]
)
