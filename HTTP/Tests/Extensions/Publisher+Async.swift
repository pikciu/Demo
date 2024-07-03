import Combine

struct PublisherResult<O, E: Error> {
    let outputs: [O]
    let completion: Subscribers.Completion<E>
}

extension Publisher {

    func untilCompleted() async -> PublisherResult<Output, Failure> {
        var outputs = [Output]()
        var cancellable: Cancellable?
        let completion = await withCheckedContinuation { continuation in
            cancellable = sink { completion in
                continuation.resume(returning: completion)
            } receiveValue: { output in
                outputs.append(output)
            }
        }
        cancellable?.cancel()
        return PublisherResult(outputs: outputs, completion: completion)
    }
}
