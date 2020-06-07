import Foundation

public protocol TwoWayMapper: Mapper {
    
    func back(from object: To) throws -> From
}
