
import UIKit
import SwiftIconFont

open class GLabel : UILabel {
    private var isUnderlined = false
    
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
    
    public func icon(_ icon: String, size: CGFloat) -> GLabel {
        self.numberOfLines = 0
        self.text = icon
        self.font = self.font.withSize(size)
        self.parseIcon()
        return self
    }
    
    public func font(_ font : UIFont) -> GLabel {
        self.font = font
        return self
    }
    
    public func bold() -> GLabel {
        return font(self.font.bold())
    }
    
    public func align(_ alignment : NSTextAlignment) -> GLabel {
        self.textAlignment = alignment
        return self
    }
    
    public func spec(_ spec : GLabelSpec) -> GLabel {
        spec.initialize(self)
        return self
    }
    
    public func click(_ target: Any, action: Selector) -> GLabel {
        self.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(gestureRecognizer)
        return self
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