import XCTest
import Combine

@testable import HTTP

final class URLSessionTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    let httpClient: HTTPClient = {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [FakeURLProtocol.self]
        return URLSession(configuration: configuration)
    }()
    
    override class func setUp() {
        super.setUp()
        URLProtocol.registerClass(FakeURLProtocol.self)
    }
    
    override class func tearDown() {
        super.tearDown()
        URLProtocol.unregisterClass(FakeURLProtocol.self)
    }
    
    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }
    
    func testExecute_forError_shouldThrowError() async {
        let request = URLRequest(url: URL(string: "https://example.com/test-1")!)
        FakeURLProtocol.results[request] = .failure(URLError(.cannotConnectToHost))
        do {
            let response = try await httpClient.execute(request: request)
            XCTFail("Should throw an error but got response: \(response)")
        } catch {
            XCTAssertNotNil(error as? URLError)
        }
    }
    
    func testExecute_forUnacceptedStatusCode_shouldThrowError() async {
        let url = URL(string: "https://example.com/test-2")!
        let request = URLRequest(url: url)
        let httpURLResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)!
        FakeURLProtocol.results[request] = .success(Response(httpURLResponse: httpURLResponse, data: Data()))
        do {
            let response = try await httpClient.execute(request: request)
            XCTFail("Should throw an error but got response: \(response)")
        } catch {
            XCTAssertNotNil(error as? HTTPError)
        }
    }
    
    func testExecute_forAcceptedStatusCode_shouldReturnSuccessResponse() async throws {
        let url = URL(string: "https://example.com/test-3")!
        let statusCode = 200
        let request = URLRequest(url: url)
        let httpURLResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        FakeURLProtocol.results[request] = .success(Response(httpURLResponse: httpURLResponse, data: Data()))
        let response = try await httpClient.execute(request: request)
        XCTAssertEqual(response.httpURLResponse.url, url)
        XCTAssertEqual(response.httpURLResponse.statusCode, statusCode)
    }
    
    func testExecute_forError_shouldFinishWithError() async {
        let request = URLRequest(url: URL(string: "https://example.com/test-4")!)
        FakeURLProtocol.results[request] = .failure(URLError(.cannotConnectToHost))
        
        let result = await httpClient.execute(request: request).untilCompleted()
        
        XCTAssertTrue(result.outputs.isEmpty)
        switch result.completion {
        case .finished:
            XCTFail("Should finish with error")
        case .failure(let error):
            switch error {
            case .requestError, .responseMapperError, .serverError:
                XCTFail("Invalid error type")
            case .urlError(let error):
                XCTAssertEqual(error.code, .cannotConnectToHost)
            }
        }
    }
    
    func testExecute_forUnacceptedStatusCode_shouldFinishWithError() async {
        let url = URL(string: "https://example.com/test-5")!
        let statusCode = 400
        let request = URLRequest(url: url)
        let httpURLResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        FakeURLProtocol.results[request] = .success(Response(httpURLResponse: httpURLResponse, data: Data()))
        
        let result = await httpClient.execute(request: request).untilCompleted()
        
        XCTAssertTrue(result.outputs.isEmpty)
        switch result.completion {
        case .finished:
            XCTFail("Should finish with error")
        case .failure(let error):
            switch error {
            case .requestError, .responseMapperError, .urlError:
                XCTFail("Invalid error type")
            case .serverError(let response):
                XCTAssertEqual(response.httpURLResponse.statusCode, statusCode)
                XCTAssertEqual(response.httpURLResponse.url, url)
            }
        }
    }
    
    func testExecute_forAcceptedStatusCode_shouldFinishWithSuccess() async {
        let url = URL(string: "https://example.com/test-6")!
        let statusCode = 200
        let request = URLRequest(url: url)
        let httpURLResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        FakeURLProtocol.results[request] = .success(Response(httpURLResponse: httpURLResponse, data: Data()))
        
        let result = await httpClient.execute(request: request).untilCompleted()
        XCTAssertEqual(result.outputs.count, 1)
        if case .failure = result.completion {
            XCTFail("Should finish with success")
        } else if let response = result.outputs.first {
            XCTAssertEqual(response.httpURLResponse.statusCode, statusCode)
            XCTAssertEqual(response.httpURLResponse.url, url)
        } else {
            XCTFail("No response")
        }
    }
}
