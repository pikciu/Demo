import Foundation

public enum LogLevel: Int {
    case off
    case verbose
    case debug
    case info
    case warning
    case error
    
    var label: String {
        "\(self)".uppercased()
    }
}
