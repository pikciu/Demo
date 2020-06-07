import Foundation
import Domain
import RxSwift

struct ObjectDecoder<Mapper: Domain.Mapper> : Transformer where Mapper.From: Decodable {
    
    typealias From = Data
    typealias To = Mapper.To
    
    let mapper: Mapper
    
    init(_ mapper: Mapper) {
        self.mapper = mapper
    }
    
    func transform(from: Observable<Data>) -> Observable<Mapper.To> {
        from.map(using: JSONMapper<Mapper.From>())
            .map(using: mapper)
            .do(onError: { (error) in
                log.error(error)
            })
    }
}
