
import UIKit
import SwiftIconFont

open class GButton: UIButton, GWeightable {
    private var helper: ViewHelper!
    private var onClick: ((GButton) -> Void)?
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
        
        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
        _ = self.paddings(t: 10, l: 20, b: 10, r: 20)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
//    public func title(_ title : String, icon: Ionicons? = nil) -> GButton {
//        let callButtonString = NSMutableAttributedString()
//        
//        if icon != nil {
//            let callIcon = String.ionicon(with: icon!)
//            let callIconAttributed = NSMutableAttributedString(string: callIcon, attributes: [NSFontAttributeName: UIFont.ionicon(of: 20)])
//            callButtonString.append(callIconAttributed)
//        }
//        
//        //let callStringAttributed = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
//        let callStringAttributed = NSMutableAttributedString(string: title)
//
//        callButtonString.append(callStringAttributed)
//        
//        self.setAttributedTitle(callButtonString, for: .normal)
//        
//        return self
//    }
    
    public func title(_ title: String) -> Self {
        self.titleLabel!.numberOfLines = 0
        self.setTitle(title, for: .normal)
        return self
    }
    
    public func iconify() -> Self {
        self.parseIcon()
        return self
    }
    
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(weight: Float, offset: Float = 0) -> Self {
        helper.width(weight: weight, offset: offset)
        return self
    }
    
    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }
    
    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }
    
    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
        let orig = self.contentEdgeInsets

        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right

        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)

        return self
    }
    
    public func specs(_ specs: GButtonSpec...) -> Self {
        for spec in specs {
            spec.decorate(self)
        }
        return self
    }
    
    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    open func onClick(_ command: @escaping (GButton) -> Void) -> Self {
        self.onClick = command
        addTarget(self, action: #selector(performClick), for: .touchUpInside)
        return self
    }
    
    @objc open func performClick() {
        if let callback = self.onClick {
            callback(self)
        }
    }
    
    public func font(_ font: UIFont?, size: Float? = nil, traits: UIFontDescriptorSymbolicTraits...) -> Self {
        var f = (font ?? self.titleLabel!.font).withTraits(traits)
        if let s = size {
            f = f.withSize(CGFloat(s))
        }
        self.titleLabel!.font = f
        return self
    }
    
    public func align(_ alignment : NSTextAlignment) -> Self {
        // The following works better when the button has multi-line text compared to
        // self.contentHorizontalAlignment which only aligns the label itself rather than the label's text
        self.titleLabel?.textAlignment = alignment
        return self
    }
    
    public func color(bg: UIColor?, text: UIColor? = nil) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        if let textColor = text {
            self.setTitleColor(textColor, for: .normal)
        }
        return self
    }
    
    public func border(color : UIColor?, width : Float = 1, corner : Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }
    
    public func enabled(_ value : Bool) -> Self {
        self.isEnabled = value
        self.alpha = value ? 1.0 : 0.5
        return self
    }
    
    public func hidden(_ hidden : Bool) -> Self {
        self.isHidden = hidden
        return self
    }
    
    public func done() {
        // End chaining
    }
}

public class GButtonSpec {
    private var decorator: ((GButton) -> Void)
    
    public init(_ decorator: @escaping ((GButton) -> Void)) {
        self.decorator = decorator
    }
    
    func decorate(_ view: GButton) {
        decorator(view)
    }
}
