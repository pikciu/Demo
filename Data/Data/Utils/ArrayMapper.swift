import Foundation
import Domain

struct ArrayMapper<M: Mapper> : Mapper where M.From: Decodable {
    let mapper: M
    
    init(_ mapper: M) {
        self.mapper = mapper
    }
    
    func map(from object: [M.From]) throws -> [M.To] {
        try object.map(mapper.map)
    }
}
