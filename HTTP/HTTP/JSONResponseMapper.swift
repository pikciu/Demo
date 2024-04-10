import Foundation

public struct JSONResponseMapper<T: Decodable>: ResponseMapper {
    
    let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    public func map(response: Response) throws -> T {
        try decoder.decode(T.self, from: response.data)
    }
}