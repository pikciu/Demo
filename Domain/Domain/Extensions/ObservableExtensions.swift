import Foundation
import RxSwift

extension ObservableType {
    public func subscribe<T: AnyObject>(
        with context: T,
        onNext: ((T, Element) -> Void)? = nil,
        onError: ((T, Swift.Error) -> Void)? = nil,
        onCompleted: ((T) -> Void)? = nil,
        onDisposed: ((T) -> Void)? = nil
    ) -> Disposable {
        subscribe(
            onNext: { [weak context] (value) in
                guard let strong = context else {
                    return
                }
                onNext?(strong, value)
            }, onError: { [weak context] (error) in
                guard let strong = context else {
                    return
                }
                onError?(strong, error)
            }, onCompleted: { [weak context] in
                guard let strong = context else {
                    return
                }
                onCompleted?(strong)
            }, onDisposed: { [weak context] in
                guard let strong = context else {
                    return
                }
                onDisposed?(strong)
            }
        )
    }
    
    public func map<M: Mapper>(using mapper: M) -> Observable<M.To> where M.From == Element  {
        map(mapper.map)
    }
    
    public func flatMap<T: AnyObject, R: ObservableConvertibleType>(with context: T, _ selector: @escaping (T, Element) throws -> R) -> Observable<R.Element> {
        flatMap({ [weak context] (next) -> Observable<R.Element> in
            guard let strong = context else {
                return Observable.empty()
            }
            return try selector(strong, next).asObservable()
        })
    }
    
    public func flatMapLatest<T: AnyObject, R: ObservableConvertibleType>(with context: T, _ selector: @escaping (T, Element) throws -> R) -> Observable<R.Element> {
        flatMapLatest({ [weak context] (next) -> Observable<R.Element> in
            guard let strong = context else {
                return Observable.empty()
            }
            return try selector(strong, next).asObservable()
        })
    }
    
    public func flatMapFirst<T: AnyObject, R: ObservableConvertibleType>(with context: T, _ selector: @escaping (T, Element) throws -> R) -> Observable<R.Element> {
        flatMapFirst({ [weak context] (next) -> Observable<R.Element> in
            guard let strong = context else {
                return Observable.empty()
            }
            return try selector(strong, next).asObservable()
        })
    }
    
    public func map<T: AnyObject, R>(with context: T, _ selector: @escaping (T, Element) throws -> R) -> Observable<R> {
        flatMap({ [weak context] (next) -> Observable<R> in
            guard let strong = context else {
                return Observable.empty()
            }
            return Observable.just(try selector(strong, next))
        })
    }
}

public extension Observable {
    
    static func just(factory: @escaping () throws -> Element) -> Observable<Element> {
        Observable.create({ (observer) -> Disposable in
            do {
                try observer.onNext(factory())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        })
    }
}
