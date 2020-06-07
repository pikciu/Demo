import Foundation

public enum Environment {
    case mock
    case production
}

public enum Build {
    case debug
    case release
}

public protocol AppConfig {
    var environment: Environment { get }
    var build: Build { get }
}
