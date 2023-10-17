import Combine
import UIKit

public extension UIControl {
    /// A publisher emitting events from this control.
    func controlEventPublisher(for events: UIControl.Event) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: self, events: events)
            .eraseToAnyPublisher()
    }
}
