import RxSwift
import RxCocoa

private struct ActivityToken<E> : ObservableConvertibleType, Disposable {
    private let source: Observable<E>
    private let disposable: Cancelable
    
    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        self.source = source
        self.disposable = Disposables.create(with: disposeAction)
    }
    
    func dispose() {
        disposable.dispose()
    }
    
    func asObservable() -> Observable<E> {
        source
    }
}

/**
 Enables monitoring of sequence computation.
 
 If there is at least one sequence computation in progress, `true` will be sent.
 When all activities complete `false` will be sent.
 */
public class ActivityIndicator : SharedSequenceConvertibleType {
    public typealias Element = Bool
    public typealias SharingStrategy = DriverSharingStrategy
    
    private let lock = NSRecursiveLock()
    private let relay = BehaviorRelay(value: 0)
    private let loading: SharedSequence<SharingStrategy, Bool>
    
    public init() {
        loading = relay.asDriver()
            .map({ $0 > 0 })
            .distinctUntilChanged()
    }
    
    fileprivate func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }, observableFactory: { (token) in token.asObservable() })
    }
    
    private func increment() {
        lock.lock()
        relay.accept(relay.value + 1)
        lock.unlock()
    }
    
    private func decrement() {
        lock.lock()
        relay.accept(relay.value - 1)
        lock.unlock()
    }
    
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Element> {
        loading
    }
    
    public func asObservable() -> Observable<Element> {
        asSharedSequence().asObservable()
    }
}

extension ObservableConvertibleType {
    public func trackActivity(_ activityIndicator: ActivityIndicator, if track: Bool = true) -> Observable<Element> {
        guard track else {
            return asObservable()
        }
        return activityIndicator.trackActivityOfObservable(self)
    }
}
