import Foundation

protocol Encoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}
