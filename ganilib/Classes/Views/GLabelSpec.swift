
import UIKit

public protocol GLabelSpec {
    func initialize(_ label : GLabel)
    func color() -> UIColor?
    func size() -> CGFloat?
    func traits() -> [UIFontDescriptorSymbolicTraits]
    func font() -> UIFont?
}

extension GLabelSpec {
    func initialize(_ label: GLabel) {
        if let font = font() {
            _ = label.font(font)
        }
        
        if let size = size() {
            _ = label.font(label.font.withSize(size))
        }
        
        if let color = color() {
            _ = label.color(color)
        }
        
       // _ = label.font(label.font.withTraits(traits()))
    }
}
