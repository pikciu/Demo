import ProjectDescription

public enum Plugins {
    
    public enum Packages {
        
        public static var swfitLint: ProjectDescription.Package = .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git", from: "0.55.1")
    }
    
    public enum Dependencies {
        
        public static var swfitLint: TargetDependency = .package(product: "SwiftLintBuildToolPlugin", type: .plugin)
    }
}
