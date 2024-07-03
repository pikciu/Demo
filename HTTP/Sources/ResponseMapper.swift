import Combine

public protocol ResponseMapper {

    associatedtype Output

    func map(response: Response) throws -> Output
}

extension ResponseMapper {

    func map(response: Response) -> AnyPublisher<Output, HTTPError> {
        do {
            let output = try map(response: response)
            return Just(output).setFailureType(to: HTTPError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: HTTPError.responseMapperError(response, error)).eraseToAnyPublisher()
        }
    }
}
