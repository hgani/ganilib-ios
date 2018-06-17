
import UIKit

public class ControlHelper<T: UIControl>: ViewHelper {
    private unowned let view: T
    private var onClick: ((T) -> Void)?
    private var onSelect: ((T) -> Void)?
    
    public init(_ view: T) {
        self.view = view
        super.init(view)
    }
    
    open func onSelect(_ command: @escaping (T) -> Void) -> Self {
        self.onSelect = command
        view.addTarget(self, action: #selector(performSelect), for: .valueChanged)
        return self
    }
    
    @objc open func performSelect() {
        if let callback = self.onSelect {
            callback(view)
        }
    }
}

