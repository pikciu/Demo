import Domain
import RealmSwift

struct ResultsMapper<M: Mapper>: Mapper where M.Source: RealmCollectionValue {
    
    let mapper: M
    
    init(_ mapper: M) {
        self.mapper = mapper
    }
    
    func map(from source: Results<M.Source>) throws -> [M.Destination] {
        try source.map(mapper.map)
    }
}
