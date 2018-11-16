import UIKit

public class EventHelper<T: UIView> {
    private unowned let view: T
    private var onClick: ((T) -> Void)?

    public init(_ view: T) {
        self.view = view
    }

    open func onClick(_ command: @escaping (T) -> Void) {
        onClick = command

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(performClick))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTap)
    }

    @objc open func performClick() {
        if let callback = self.onClick {
            callback(view)
        }
    }
}
