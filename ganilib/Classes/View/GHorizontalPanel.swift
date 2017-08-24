
import UIKit

open class GHorizontalPanel : UIView {
    private var helper : ViewHelper!
    private var previousViewElement : UIView!
    private var previousConstraint : NSLayoutConstraint!
    private var horizontalPadding : Bool = true
    
    private var paddings = UIEdgeInsetsMake(0, 0, 0, 0)
    
    public init(horizontalPadding : Bool = true) {
        super.init(frame: .zero)
        
        self.helper = ViewHelper(self)
        self.horizontalPadding = horizontalPadding
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func clearViews() {
        previousViewElement = nil
        previousConstraint = nil
        
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    public func addView(_ child : UIView, left: CGFloat = 0) {
        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false
        
        super.addSubview(child)
        initChildConstraints(child: child, left: left)
        adjustParentBottomConstraint(child: child)
        
        previousViewElement = child
    }
    
    public func append(_ child : UIView, left: CGFloat = 0) -> Self {
        addView(child, left: left)
        return self
    }
    
    // See https://github.com/zaxonus/AutoLayScroll/blob/master/AutoLayScroll/ViewController.swift
    private func initChildConstraints(child: UIView, left: CGFloat) {
        child.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            
            if previousViewElement == nil {
                make.left.equalTo(self).offset(left)
            }
            else {
                make.left.equalTo(previousViewElement.snp.right).offset(left)
            }
        }
    }
    
    private func adjustParentBottomConstraint(child : UIView) {
        self.snp.makeConstraints { (make) -> Void in
            make.bottom.greaterThanOrEqualTo(child)
        }

        if previousConstraint != nil {
            self.removeConstraint(previousConstraint)
        }
        
        previousConstraint = NSLayoutConstraint(item: child,
                                                attribute: .right,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .right,
                                                multiplier: 1.0,
                                                constant: -paddings.right)
        self.addConstraint(previousConstraint)
    }
    
    public func width(_ width : Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func height(_ height : Int) -> Self {
        helper.height(height)
        return self
    }
    
    // NOTE: At the moment, this only works it gets called before children get added
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        let orig = self.paddings
        
        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right
        
        self.paddings = UIEdgeInsetsMake(top, left, bottom, right)
        return self
    }
    
    public func color(bg: UIColor) -> Self {
        self.backgroundColor = bg
        return self
    }
    
    open override func addSubview(_ view: UIView) {
        fatalError("Use addView() instead")
    }
}
