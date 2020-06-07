import Foundation
import Domain

struct JSONMapper<Model: Decodable>: Mapper {
    let decoder = JSONDecoder()
    
    func map(from object: Data) throws -> Model {
        do {
#if DEBUG
            let json = String(bytes: object, encoding: .utf8) ?? ""
            log.verbose("bytes: \(object.count)\n\(json)")
#endif
            return try decoder.decode(Model.self, from: object)
        } catch {
            log.error(error)
            throw AppError.mappingError(error)
        }
    }
}
