import Foundation

public protocol Mapper {
    associatedtype Source
    associatedtype Destination

    func map(from source: Source) throws -> Destination
}
