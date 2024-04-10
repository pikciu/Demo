import Combine

extension Publisher {

    public func sink<T: AnyObject>(
        with object: T,
        receiveCompletion: @escaping (T, Subscribers.Completion<Failure>) -> Void,
        receiveValue: @escaping (T, Output) -> Void
    ) -> Cancellable {
        sink { [weak object] completion in
            guard let object = object else {
                return
            }
            receiveCompletion(object, completion)
        } receiveValue: { [weak object] output in
            guard let object = object else {
                return
            }
            receiveValue(object, output)
        }
    }
}

extension Publisher where Output == Never {

    public func sink(completion: @escaping (Subscribers.Completion<Failure>) -> Void) -> Cancellable {
        sink(
            receiveCompletion: completion,
            receiveValue: { _ in }
        )
    }
}

extension Publisher where Output == Void {

    public func sink(completion: @escaping (Subscribers.Completion<Failure>) -> Void) -> Cancellable {
        sink(
            receiveCompletion: completion,
            receiveValue: { _ in }
        )
    }
}

extension Publisher where Failure == Never {

    public func sink<T: AnyObject>(with object: T, receiveValue: @escaping (T, Output) -> Void) -> Cancellable {
        sink { [weak object] value in
            guard let object = object else {
                return
            }
            receiveValue(object, value)
        }
    }

    public func sink<T: AnyObject>(with object: T, receiveValue: @escaping (T) -> Void) -> Cancellable {
        sink { [weak object] _ in
            guard let object = object else {
                return
            }
            receiveValue(object)
        }
    }
}
