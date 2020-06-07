import Foundation
import Domain
import RxSwift

final class APIClient {
    private let httpClient = HTTPClient()
    
    func execute<M: Mapper>(request: RequestType, responseMapper: M) -> Observable<M.To> where M.From: Decodable {
        do {
            return execute(request: try request.build(), responseMapper: responseMapper)
        } catch {
            return Observable.error(error)
        }
    }
    
    func execute<M: Mapper>(request: RequestType, elementMapper: M) -> Observable<[M.To]> where M.From: Decodable {
        do {
            return execute(request: try request.build(), elementMapper: elementMapper)
        } catch {
            return Observable.error(error)
        }
    }
    
    func execute(request: RequestType) -> Observable<Void> {
        do {
            return execute(request: try request.build())
        } catch {
            return Observable.error(error)
        }
    }
    
    func execute<M: Mapper>(request: Request, responseMapper: M) -> Observable<M.To> where M.From: Decodable {
        executeRaw(request: request)
            .map({ $0.body })
            .apply(transform: ObjectDecoder(responseMapper))
    }
    
    func execute<M: Mapper>(request: Request, elementMapper: M) -> Observable<[M.To]> where M.From: Decodable {
        executeRaw(request: request)
            .map({ $0.body })
            .apply(transform: ArrayDecoder(elementMapper))
    }
    
    func execute(request: Request) -> Observable<Void> {
        executeRaw(request: request).mapTo(())
    }
    
    func executeRaw(request: RequestType) -> Observable<Response> {
        do {
            return executeRaw(request: try request.build())
        } catch {
            return Observable.error(error)
        }
    }
    
    func executeRaw(request: Request) -> Observable<Response> {
        httpClient.execute(request: request)
    }
}
