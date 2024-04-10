import Combine
import UIKit

extension UIBarButtonItem {

    struct Publisher: Combine.Publisher {
        typealias Output = UIBarButtonItem
        typealias Failure = Never

        let button: UIBarButtonItem

        func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
            let subscription = Subscription(subscriber: subscriber, button: button)
            subscriber.receive(subscription: subscription)
        }
    }

    private final class Subscription<S: Subscriber>: Combine.Subscription
    where S.Failure == Never, S.Input == UIBarButtonItem {

        let subscriber: S
        let button: UIBarButtonItem

        init(
            subscriber: S,
            button: UIBarButtonItem
        ) {
            self.subscriber = subscriber
            self.button = button
        }

        func request(_ demand: Subscribers.Demand) {
            button.target = self
            button.action = #selector(action)
        }

        func cancel() {
            button.target = nil
            button.action = nil
        }

        @objc
        private func action() {
            _ = subscriber.receive(button)
        }
    }

    var publisher: Publisher {
        Publisher(button: self)
    }
}
