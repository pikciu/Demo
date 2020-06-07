import Foundation

public enum LogLevel: Int {
    case off
    case verbose
    case debug
    case info
    case warning
    case error
    
    var label: String {
        switch self {
        case .off:
            return "🤷‍♂️"
        case .verbose:
            return "💙"
        case .debug:
            return "💚"
        case .info:
            return "💜"
        case .warning:
            return "💛"
        case .error:
            return "❤️"
        }
    }
}
