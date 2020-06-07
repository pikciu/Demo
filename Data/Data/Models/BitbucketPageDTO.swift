import Foundation
import Domain

struct BitbucketPageDTO<T: Decodable>: Decodable {
    let pagelen: Int
    let values: [T]
}

struct BitbucketPageMapper<M: Mapper>: Mapper where M.From: Decodable {
    let mapper: M
    
    init(_ mapper: M) {
        self.mapper = mapper
    }

    func map(from object: BitbucketPageDTO<M.From>) throws -> [M.To] {
        try object.values.map(mapper.map)
    }
}
