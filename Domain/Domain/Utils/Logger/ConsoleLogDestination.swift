import Foundation

public struct ConsoleLogDestination: LogDestination {
    public func log(message: String) {
        print(message)
    }
}
