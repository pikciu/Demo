import Foundation

public let log = Logger(destinations: ConsoleLogDestination())

public final class Logger {
    
    private let destinations: [LogDestination]
    private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSS"
       return formatter
    }()
    
    init(destinations: LogDestination...) {
        self.destinations = destinations
    }
    
    public var logLevel: LogLevel = .off
    
    func log(
        _ object: @autoclosure @escaping () -> Any,
        level: LogLevel,
        filename: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        guard logLevel != .off, level.rawValue >= logLevel.rawValue else {
            return
        }
        let date = dateFormatter.string(from: Date())
        let file = filename.components(separatedBy: "/").last ?? ""
        
        let message = "\(date) \(level.label) \(file):\(line) \(function)\n\(object())"
        
        destinations.forEach { (destination) in
            destination.log(message: message)
        }
    }
    
    public func verbose(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .verbose, filename: filename, line: line, function: function)
    }
    
    public func debug(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .debug, filename: filename, line: line, function: function)
    }
    
    public func info(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .info, filename: filename, line: line, function: function)
    }
    
    public func warning(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .warning, filename: filename, line: line, function: function)
    }
    
    public func error(_ object: @autoclosure @escaping () -> Any, filename: String = #file, line: Int = #line, function: String = #function) {
        log(object, level: .error, filename: filename, line: line, function: function)
    }
}
