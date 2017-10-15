
import UIKit
import SwiftIconFont
import TTTAttributedLabel

open class GLabel: UILabel {
    private var helper : ViewHelper!
    private var isUnderlined = false
    private var onClick : ((GLabel) -> Void)?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func color(_ color: UIColor) -> Self {
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
    
    public func text(_ text : String) -> Self {
        self.numberOfLines = 0
        self.text = text
        return self
    }
    
    public func icon(_ icon: String, size: CGFloat) -> Self {
        self.numberOfLines = 0
        self.text = icon
        self.font = self.font.withSize(size)
        self.parseIcon()
        return self
    }
    
    // Has to be called before text()
    public func font(_ font: UIFont?, size: Float? = nil, traits: UIFontDescriptorSymbolicTraits...) -> Self {
        var f = (font ?? self.font).withTraits(traits)
        if let s = size {
            f = f.withSize(CGFloat(s))
        }
        self.font = f
        return self
    }
    
//    public func font(size: Float? = nil, traits: UIFontDescriptorSymbolicTraits...) -> Self {
//        var f = self.font.withTraits(traits)
//        if let s = size {
//           f = f.withSize(CGFloat(s))
//        }
////        if let t = traits {
////            f = f.withTraits(traits)
////        }
//        return font(f)
//    }

    // TODO: Consider deprecating this, but how about underline()
    public func bold() -> Self {
        return font(self.font.bold())
    }
    
//    public func size(w: Int?, h: Int?) -> Self {
//        helper.size(width: w, height: h)
//        return self
//    }
    
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(weight: Float) -> Self {
        helper.width(weight: weight)
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
    
    public func align(_ alignment : NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    public func spec(_ spec : GLabelSpec) -> Self {
        spec.decorate(self)
        return self
    }
    
    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    public func onClick(_ command: @escaping (GLabel) -> Void) -> Self {
        self.onClick = command
        self.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(performClick))
        self.addGestureRecognizer(gestureRecognizer)
        return self
    }
    
    @objc private func performClick() {
        if let callback = self.onClick {
            callback(self)
        }
    }
    
    public func underline() -> Self {
        self.isUnderlined = true
        return self
    }
    
    public func end() {
        // Ends chaining
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

public class GLabelSpec {
    private var decorator: ((GLabel) -> Void)

    public init(_ decorator: @escaping ((GLabel) -> Void)) {
        self.decorator = decorator
    }
    
    func decorate(_ view: GLabel) {
        decorator(view)
    }
}
