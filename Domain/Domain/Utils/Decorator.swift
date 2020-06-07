import Foundation

public protocol Decorator {
    associatedtype Object
    associatedtype Result
    
    func apply(on object: Object) -> Result
}
