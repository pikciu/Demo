import Foundation

public struct URLMapper: TwoWayMapper {

    struct InvalidURL: Error {}

    public init() {}

    public func map(from url: String) throws -> URL {
        guard let url = URL(string: url) else {
            throw InvalidURL()
        }
        return url
    }

    public func back(from url: URL) -> String {
        url.absoluteString
    }
}
