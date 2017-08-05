
import UIKit
import SwiftIconFont
import TTTAttributedLabel

open class GLabel : TTTAttributedLabel {
    private var isUnderlined = false
    private var onClick : ((GLabel) -> Void)?
    
    public func color(_ color: UIColor) -> GLabel {
        self.textColor = color
        return self
    }
    
    public func color(bg : UIColor?, text: UIColor? = nil) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        if let textColor = text {
            self.textColor = textColor
        }
        return self
    }
    
    public func text(_ text : String) -> GLabel {
        self.numberOfLines = 0
        self.text = text
        return self
    }
    
    // https://developer.apple.com/documentation/foundation/nstextcheckingtypes
    // https://developer.apple.com/documentation/foundation/nstextcheckingtype
    public func checkingTypes(_ mode : NSTextCheckingTypes) -> Self {
        self.enabledTextCheckingTypes = mode
        return self
    }
    
    public func icon(_ icon: String, size: CGFloat) -> GLabel {
        self.numberOfLines = 0
        self.text = icon
        self.font = self.font.withSize(size)
        self.parseIcon()
        return self
    }
    
    // Has to be called before text()
    public func font(_ font : UIFont) -> Self {
        self.font = font
        return self
    }
    
    public func font(size: Float? = nil, traits: UIFontDescriptorSymbolicTraits...) -> Self {
        var f = self.font.withTraits(traits)
        if let s = size {
           f = f.withSize(CGFloat(s))
        }
//        if let t = traits {
//            f = f.withTraits(traits)
//        }
        return font(f)
//        return font(self.font.).withTraits(traits: traits))
//        return self
    }
    
//    public func bold() -> Self {
//        return font(self.font.bold())
//    }
    
    public func align(_ alignment : NSTextAlignment) -> GLabel {
        self.textAlignment = alignment
        return self
    }
    
    public func spec(_ spec : GLabelSpec) -> GLabel {
        spec.initialize(self)
        return self
    }
    
    // NOTE: Deprecated. Use onClick() instead
    public func click(_ target: Any, action: Selector) -> GLabel {
        self.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gestureRecognizer)
        return self
    }
    
    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    public func onClick(_ command: @escaping (GLabel) -> Void) -> Self {
        self.onClick = command
//        addTarget(self, action: #selector(performClick), for: .touchUpInside)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(performClick))
        self.addGestureRecognizer(gestureRecognizer)
        return self
    }
    
    @objc private func performClick() {
        if let callback = self.onClick {
            callback(self)
        }
    }
    
    public func underline() -> GLabel {
        self.isUnderlined = true
        return self
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isUnderlined {
            let startingPoint   = CGPoint(x: rect.minX, y: rect.maxY - 2)
            let endingPoint     = CGPoint(x: rect.maxX, y: rect.maxY - 2)

            let path = UIBezierPath()
            
            path.move(to: startingPoint)
            path.addLine(to: endingPoint)
            
            let traits = CTFontGetSymbolicTraits(font)
            let isBold = (traits == CTFontSymbolicTraits.traitBold)
            path.lineWidth = isBold ? 2.0 : 1.0
            
            textColor.setStroke()
            
            path.stroke()
        }
    }
}
