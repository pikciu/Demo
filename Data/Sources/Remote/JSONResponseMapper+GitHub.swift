import Foundation
import HTTP

extension JSONResponseMapper {

    static func gitHub() -> JSONResponseMapper {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return JSONResponseMapper(decoder: decoder)
    }
}
