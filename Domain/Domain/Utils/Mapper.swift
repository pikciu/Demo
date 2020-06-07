import Foundation

public protocol Mapper {
    associatedtype From
    associatedtype To
    
    func map(from object: From) throws -> To
}
