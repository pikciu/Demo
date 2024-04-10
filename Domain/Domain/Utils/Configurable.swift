import Foundation

public protocol Configurable {
    associatedtype Object

    func configure(with object: Object)
}
