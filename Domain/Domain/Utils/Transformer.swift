import Foundation
import RxSwift
import RxSwiftExt

public protocol Transformer {
    associatedtype From
    associatedtype To
    
    func transform(from: Observable<From>) -> Observable<To>
}

extension ObservableType {
    
    public func apply<T: Transformer>(transform: T) -> Observable<T.To> where T.From == Element {
        apply(transform.transform)
    }
}
