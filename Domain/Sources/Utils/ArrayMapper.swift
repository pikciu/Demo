import Foundation

public struct ArrayMapper<M: Mapper>: Mapper {
    let mapper: M

    public init(_ mapper: M) {
        self.mapper = mapper
    }

    public func map(from source: [M.Source]) throws -> [M.Destination] {
        try source.map(mapper.map)
    }
}
