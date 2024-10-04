import ProjectDescription

public enum Dependencies {
    
    public struct Local: Sendable {
        let name: String
        let path: Path
        
        public var project: TargetDependency {
            .project(target: name, path: path)
        }
        
        public var target: TargetDependency {
            .target(name: name)
        }
        
        init(name: String) {
            self.name = name
            self.path = "../\(name)"
        }
        
        init(name: String, path: Path) {
            self.name = name
            self.path = path
        }
    }

    public static let swfitLint: TargetDependency = .package(product: "SwiftLintBuildToolPlugin", type: .plugin)
    
    public static let ean: TargetDependency = .external(name: "EANView")
    public static let utils: TargetDependency = .external(name: "SwiftUI-Utils")
    public static let realmSwift: TargetDependency = .external(name: "RealmSwift")
    public static let realm: TargetDependency = .external(name: "Realm")
    public static let container: TargetDependency = .external(name: "Container")
    
    public static let app = Local(name: .app)
    public static let data = Local(name: .data)
    public static let domain = Local(name: .domain)
    public static let http = Local(name: .http)
    public static let resources = Local(name: .resources)
}
