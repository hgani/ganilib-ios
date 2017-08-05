import UIKit

open class GTextField: UITextField {
    private var helper: ViewHelper!
    private var padding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    
    public init() {
        super.init(frame: .zero)
        
        self.helper = ViewHelper(self)
        
        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
//        _ = self.padding(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func placeholder(_ str: String) -> Self {
        self.placeholder = str
        return self
    }
    
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
//        helper.padding(top: top, left: left, bottom: bottom, right: right)
//        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
        
        let orig = self.padding
        
        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right
        
        self.padding = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    public func border(color : UIColor?, width : Float = 1, corner : Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }
}
