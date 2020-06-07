import Foundation

public protocol Decorable {
}

extension Decorable {
    @discardableResult
    public func apply<D: Decorator>(_ decorator: D) -> D.Result where D.Object == Self {
        decorator.apply(on: self)
    }
}

extension NSObject : Decorable {
    
}
