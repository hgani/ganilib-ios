
import UIKit

public class ControlHelper<T: UIControl>: ViewHelper {
    private unowned let view: T
    private var onClick: ((T) -> Void)?
    private var onSelect: ((T) -> Void)?
    
    public init(_ view: T) {
        self.view = view
        super.init(view)
    }
    
    open func onClick(_ command: @escaping (T) -> Void) -> Self {
        self.onClick = command
        view.addTarget(self, action: #selector(performClick), for: .touchUpInside)
        return self
    }
    
    @objc open func performClick() {
        if let callback = self.onClick {
            callback(view)
        }
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

