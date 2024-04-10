import Combine
import UIKit

extension NSObjectProtocol where Self: UIControl {

    func publisher(for event: UIControl.Event) -> UIControl.EventPublisher<Self> {
        EventPublisher(control: self, event: event)
    }
}

extension UIControl {

    final class EventSubscription<S: Subscriber, C: UIControl>: Subscription where S.Input == C {
        private let subscriber: S
        private let control: C
        private let event: UIControl.Event

        init(
            subscriber: S,
            control: C,
            event: UIControl.Event
        ) {
            self.subscriber = subscriber
            self.control = control
            self.event = event

            control.addTarget(self, action: #selector(handle), for: event)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            control.removeTarget(self, action: #selector(handle), for: event)
        }

        @objc
        private func handle(sender: UIControl) {
            _ = subscriber.receive(sender as! C)
        }
    }

    struct EventPublisher<C: UIControl>: Publisher {
        public typealias Output = C
        public typealias Failure = Never

        private let control: C
        private let event: UIControl.Event

        init(
            control: C,
            event: UIControl.Event
        ) {
            self.control = control
            self.event = event
        }

        func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Failure, S.Input == Output {
            let subscription = EventSubscription(subscriber: subscriber, control: control, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
}
