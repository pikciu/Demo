import Foundation
import Domain

protocol RequestType {
    func build() throws -> Request
}
