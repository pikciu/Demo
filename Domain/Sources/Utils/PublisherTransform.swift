import Combine

public protocol PublisherTransform {
    associatedtype Upstream: Publisher
    associatedtype Downstream: Publisher
    
    func transform(upstream: Upstream) -> Downstream
}

extension Publisher {
    
    func apply<T: PublisherTransform>(_ transform: T) -> T.Downstream where T.Upstream == Self {
        transform.transform(upstream: self)
    }
}
