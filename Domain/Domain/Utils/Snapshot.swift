import Combine

public struct Snapshot<D> {
    public let data: D
    public let animate: Bool
}

struct SnapshotTransform<P: Publisher>: PublisherTransform {
    
    func transform(upstream: P) -> AnyPublisher<Snapshot<P.Output>, P.Failure> {
        upstream.scan(nil as Snapshot<P.Output>?) { result, next in
            if result == nil {
                return Snapshot(data: next, animate: false)
            } else {
                return Snapshot(data: next, animate: true)
            }
        }
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }
}
