
import UIKit
import SwiftIconFont

open class GBarButtonItem: UIBarButtonItem {
    private var onClick : (() -> Void)?
    
//    public override init() {
//        super.init()
//        
//        self.helper = ViewHelper(self)
//        
//        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
////        _ = self.padding(top: 10, left: 20, bottom: 10, right: 20)
//    }
//    
//    required public init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
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
    
    public func end() {
        // End chaining initialisation
    }
}
