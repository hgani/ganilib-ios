import SwiftIconFont
import UIKit

open class GBarButtonItem: UIBarButtonItem {
    private var onClick: (() -> Void)?

    public func onClick(_ command: @escaping () -> Void) -> Self {
        onClick = command
        target = self
        action = #selector(performClick)
        return self
    }

    @objc private func performClick() {
        if let callback = self.onClick {
            callback()
        }
    }

    public func icon(_ icon: GIcon) -> Self {
        super.icon(from: icon.font, code: icon.code, ofSize: 20)
        return self
    }

    public func title(_ text: String) -> Self {
        super.title = text
        return self
    }

    public func end() {
        // End chaining initialisation
    }
}
