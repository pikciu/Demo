import Foundation
import Domain

protocol EncodableRequestType: RequestType {
    associatedtype E: Encodable
    
    var defaultHeaders: [HTTPHeader] { get }
    var encoder: Encoder { get }
    
    func encodable() throws -> E
}

extension EncodableRequestType where Self: Encodable {
    func encodable() -> Self {
        self
    }
}
