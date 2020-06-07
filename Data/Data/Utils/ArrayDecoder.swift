import Foundation
import Domain
import RxSwift

struct ArrayDecoder<Mapper: Domain.Mapper> : Transformer where Mapper.From: Decodable {
    
    typealias From = Data
    typealias To = [Mapper.To]
    
    let mapper: Mapper
    
    init(_ mapper: Mapper) {
        self.mapper = mapper
    }
    
    func transform(from: Observable<Data>) -> Observable<To> {
        let dtos = from.map(using: JSONMapper<[Mapper.From]>())
        return dtos.map({ (array) -> To in
            try array.map(self.mapper.map)
        }).do(onError: { (error) in
            log.error(error)
        })
    }
}
