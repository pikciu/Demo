import Foundation
import RxSwift
import Domain

struct Mock {
    private let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    init(filename: String, parameters: [Any]) {
        let params = parameters.map({ "\($0)" }).joined(separator: "_")
        self.init(filename: "\(filename)_\(params)")
    }
    
    func load<T: Decodable>() -> Observable<T> {
        let mock: Observable<T> = Observable.create({ (observer) -> Disposable in
            log.verbose("mock request: \(self.filename)")
            guard
                let url = Bundle(for: BundleToken.self).url(forResource: self.filename, withExtension: "json"),
                let content = try? Data(contentsOf: url)
            else {
                log.warning("File not found: \(self.filename)")
                observer.onError(AppError.descriptive("Mock file not found"))
                return Disposables.create()
            }
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(T.self, from: content)
                observer.onNext(response)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        })
        return mock
    }
    
    func load<M: Mapper>(mapper: M) -> Observable<M.To> where M.From: Decodable {
        let dto: Observable<M.From> = load()
        return dto.map(using: mapper)
    }
}

private final class BundleToken {
}
