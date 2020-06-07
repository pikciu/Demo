import Foundation

public protocol LogDestination {
    
    func log(message: String)
}
