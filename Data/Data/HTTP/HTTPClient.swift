import Foundation
import RxSwift
import Domain

final class HTTPClient {
    
    func execute(request: Request) -> Observable<Response> {
        guard let urlRequest = createRequest(from: request) else {
            return Observable.error(HTTPError.invalidRequest)
        }
        
        let observable: Observable<Response> = Observable.create { observer in
            let session = Container.resolve(URLSession.self)
            let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
                
                log.verbose(request.resource)
                
                if let error = error {
                    observer.onError(HTTPError.networkError(error))
                    return
                }
                
                guard
                    let httpResponse = urlResponse as? HTTPURLResponse,
                    let data = data
                else {
                    observer.onError(HTTPError.noResponse)
                    return
                }
          
                guard 200..<300 ~= httpResponse.statusCode else {
                    let json = String(bytes: data, encoding: .utf8) ?? ""
                    log.verbose(json)
                    observer.onError(HTTPError.httpError(status: httpResponse.statusCode, data: data))
                    return
                }
                
                let response = Response(
                    body: data,
                    httpResponse: httpResponse
                )
                observer.onNext(response)
                observer.onCompleted()
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
        
        return observable.observeOn(MainScheduler.instance)
            .share(replay: 1, scope: .whileConnected)
            .do(onError: { (error) in
                log.error(error)
            })
    }
    
    private func createRequest(from request: Request) -> URLRequest? {
        guard let resource = request.resource.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return nil
        }
        guard let url = URL(string: resource) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.body
        for header in request.headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }
        return urlRequest
    }
}
