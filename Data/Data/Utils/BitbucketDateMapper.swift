import Foundation
import Domain

struct BitbucketDateMapper: TwoWayMapper {
    let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let dateFormatter = DateTimeFormatter(timeZone: .utc, locale: Locale(identifier: "en_US_POSIX"))
    
    func map(from object: String) throws -> Date {
        guard let date = dateFormatter.date(from: object, dateFormat: dateFormat) else {
            throw AppError.descriptive("Parsing date error: \(object)")
        }
        return date
    }
    
    func back(from object: Date) -> String {
        dateFormatter.string(from: object, dateFormat: dateFormat)
    }
}
