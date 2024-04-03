import Foundation

public protocol Request {
    func urlRequest() throws -> URLRequest
}
