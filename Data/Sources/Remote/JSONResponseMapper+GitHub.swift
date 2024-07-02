import HTTP
import Foundation

extension JSONResponseMapper {
    
    static func gitHub() -> JSONResponseMapper {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return JSONResponseMapper(decoder: decoder)
    }
}
