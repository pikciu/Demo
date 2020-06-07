import Foundation

protocol EndpointType {
    func resolve() throws -> String
}
