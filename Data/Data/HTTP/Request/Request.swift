import Foundation

struct Request {
    let resource: String
    let httpMethod: HTTPMethod
    let body: Data?
    let headers: [HTTPHeader]
    
    init(endpoint: EndpointType, httpMethod: HTTPMethod, body: Data? = nil, headers: [HTTPHeader] = []) throws {
        try self.init(resource: endpoint.resolve(), httpMethod: httpMethod, body: body, headers: headers)
    }
    
    init(resource: String, httpMethod: HTTPMethod, body: Data? = nil, headers: [HTTPHeader] = []) {
        self.resource = resource
        self.httpMethod = httpMethod
        self.body = body
        self.headers = headers
    }
}
