import Combine

extension Publisher {
    
    public func enumerated() -> AnyPublisher<(Int, Output), Failure> {
        scan(Optional<(Int, Output)>.none) { acc, next in
            guard let acc = acc else { return (0, next) }
            return (acc.0 + 1, next)
        }
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }
}
