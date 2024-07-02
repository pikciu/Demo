import Foundation

public protocol TwoWayMapper: Mapper {
    
    func back(from destination: Destination) throws -> Source
}
