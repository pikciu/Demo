import Foundation

protocol QueryType {
    var query: [String: String] { get }
}

extension QueryType {
    var queryString: String {
        query.map({ (key, value) in "\(key)=\(value)" })
            .joined(separator: "&")
    }
}
