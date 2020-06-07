import Foundation

protocol JSONEncodableRequestType: EncodableRequestType {
    
}

extension JSONEncodableRequestType {
    var defaultHeaders: [HTTPHeader] {
        [.contentType(.json)]
    }
    
    var encoder: Encoder {
        JSONEncoder()
    }
}
