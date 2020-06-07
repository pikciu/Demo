import Foundation
import Domain

public enum HTTPHeader: Hashable {
    
    public enum ContentType: Hashable {
        case json
        
        var value: String {
            switch self {
            case .json:
                return "application/json"
            }
        }
    }
    
    public enum Authorization: Hashable {
        case basic(String)
        case bearer(String)
        
        var value: String {
            switch self {
            case .basic(let token):
                return "Basic \(token)"
            case .bearer(let token):
                return "Bearer \(token)"
            }
        }
    }
    
    case contentType(ContentType)
    case authorization(Authorization)
    
    public var key: String {
        switch self {
        case .authorization:
            return "Authorization"
        case .contentType:
            return "Content-Type"
        }
    }
    
    public var value: String {
        switch self {
        case .authorization(let authorization):
            return authorization.value
        case .contentType(let contentType):
            return contentType.value
        }
    }
}
