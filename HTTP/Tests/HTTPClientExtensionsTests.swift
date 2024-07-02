import XCTest
import Combine

@testable import HTTP

final class HTTPClientExtensionsTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    let httpClient = FakeHTTPClient()
    
    override func tearDown() {
        super.tearDown()
        httpClient.result = nil
        cancellables.removeAll()
    }
    
    func testExecute_forValidRequest_andSuccessResponse_shouldReturnExepctedResponse() async throws {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com/test-1")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let exepctedResponse = Response(httpURLResponse: response!, data: Data())
        httpClient.result = .success(exepctedResponse)
        
        let result = try await httpClient.execute(request: TestValidRequest())
        XCTAssertEqual(result.httpURLResponse.statusCode, response?.statusCode)
        XCTAssertEqual(result.httpURLResponse.url, response?.url)
    }
    
    func testExecute_forValidRequest_andFailureResponse_shouldThrowError() async {
        httpClient.result = .failure(.urlError(URLError(.cannotFindHost)))
        
        do {
            let result = try await httpClient.execute(request: TestValidRequest())
            XCTFail("Should thrown an error but got response: \(result)")
        } catch {
            XCTAssertNotNil(error as? HTTPError)
        }
    }
    
    func testExecute_forInvalidRequest_shouldThrowError() async {
        do {
            let result = try await httpClient.execute(request: TestInvalidRequest())
            XCTFail("Should thrown an error but got response: \(result)")
        } catch {
            XCTAssertNotNil(error as? HTTPError)
        }
    }
    
    func testExecute_forValidRequest_andSuccessResponse_shouldFinishWithSuccess() async {
        let exepctedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com/test-1")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        httpClient.result = .success(Response(httpURLResponse: exepctedResponse!, data: Data()))
        
        let result = await httpClient.execute(request: TestValidRequest()).untilCompleted()
        XCTAssertEqual(result.outputs.count, 1)
        if case .failure = result.completion {
            XCTFail("Should finish with success")
        } else if let response = result.outputs.first {
            XCTAssertEqual(response.httpURLResponse.statusCode, exepctedResponse?.statusCode)
            XCTAssertEqual(response.httpURLResponse.url, exepctedResponse?.url)
        } else {
            XCTFail("No response")
        }
    }
    
    func testExecute_forValidRequest_andFailureResponse_shouldFinishWithError() async {
        httpClient.result = .failure(.urlError(URLError(.cannotFindHost)))
        
        let result = await httpClient.execute(request: TestValidRequest()).untilCompleted()
        XCTAssertTrue(result.outputs.isEmpty)
        switch result.completion {
        case .finished:
            XCTFail("Should finish with error")
        case .failure(let error):
            switch error {
            case .requestError, .responseMapperError, .serverError:
                XCTFail("Invalid error")
            case .urlError(let urlError):
                XCTAssertEqual(urlError.code, .cannotFindHost)
            }
        }
    }
    
    func testExecute_forInvalidRequest_shouldFinishWithError() async {
        let result = await httpClient.execute(request: TestInvalidRequest()).untilCompleted()
        XCTAssertTrue(result.outputs.isEmpty)
        switch result.completion {
        case .finished:
            XCTFail("Should finish with error")
        case .failure(let error):
            switch error {
            case .responseMapperError, .serverError, .urlError:
                XCTFail("Invalid error")
            case .requestError(let request, _):
                XCTAssertTrue(request is TestInvalidRequest)
            }
        }
    }
    
    func testExecute_forValidRequest_andSuccessResponse_butEmptyBody_shouldThrownError() async {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com/test-1")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let exepctedResponse = Response(httpURLResponse: response!, data: Data())
        httpClient.result = .success(exepctedResponse)
        
        do {
            let result = try await httpClient.execute(
                request: TestValidRequest(),
                responseMapper: JSONResponseMapper<TestResponse>()
            )
            XCTFail("Should throw an error but got: \(result)")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func testExecute_forValidRequest_andValidBody_shouldReturnValidResponse() async throws {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com/test-1")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let exepctedResponse = TestResponse(name: "test-1")
        httpClient.result = .success(Response(httpURLResponse: response!, data: exepctedResponse.data))
        
        let result = try await httpClient.execute(
            request: TestValidRequest(),
            responseMapper: JSONResponseMapper<TestResponse>()
        )
        XCTAssertEqual(result, exepctedResponse)
    }
    
    func testExecute_forValidRequest_andSuccessResponse_butEmptyBody_shouldFinishWithError() async {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com/test-1")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let exepctedResponse = Response(httpURLResponse: response!, data: Data())
        httpClient.result = .success(exepctedResponse)
        
        let result = await httpClient.execute(
            request: TestValidRequest(),
            responseMapper: JSONResponseMapper<TestResponse>()
        ).untilCompleted()
        XCTAssertTrue(result.outputs.isEmpty)
        switch result.completion {
        case .finished:
            XCTFail("Should finish with error")
        case .failure(let error):
            switch error {
            case .requestError, .serverError, .urlError:
                XCTFail("Invalid error")
            case .responseMapperError(_, let error):
                XCTAssertTrue(error is DecodingError)
            }
        }
    }
    
    func testExecute_forValidRequest_andValidBody_shouldFinishWithValidResponse() async {
        let response = HTTPURLResponse(
            url: URL(string: "https://example.com/test-2")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        let exepctedResponse = TestResponse(name: "test-2")
        httpClient.result = .success(Response(httpURLResponse: response!, data: exepctedResponse.data))
        
        let result = await httpClient.execute(
            request: TestValidRequest(),
            responseMapper: JSONResponseMapper<TestResponse>()
        ).untilCompleted()
        XCTAssertEqual(result.outputs.count, 1)
        if case .failure = result.completion {
            XCTFail("Should finish with success")
        } else if let response = result.outputs.first {
            XCTAssertEqual(response, exepctedResponse)
        } else {
            XCTFail("No response")
        }
    }
}
