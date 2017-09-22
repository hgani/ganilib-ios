
import UIKit
import SwiftIconFont

open class GBarButtonItem: UIBarButtonItem {
    private var onClick : (() -> Void)?
    
    public func onClick(_ command: @escaping () -> Void) -> Self {
        self.onClick = command
        self.target = self
        self.action = #selector(performClick)
        return self
    }
    
    @objc private func performClick() {
        if let callback = self.onClick {
            callback()
        }
    }
    
    public func icon(from font: Fonts, code: String) -> Self {
        super.icon(from: font, code: code, ofSize: 20)
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
