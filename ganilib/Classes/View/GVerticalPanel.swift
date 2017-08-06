
import UIKit

open class GVerticalPanel : UIView {
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
    
    public func addView(_ child : UIView, top : CGFloat? = nil) {
        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(child)
        initChildConstraints(child: child, top: top ?? 0)
        adjustParentBottomConstraint(child: child)
        
        previousViewElement = child
    }
    
    // See https://github.com/zaxonus/AutoLayScroll/blob/master/AutoLayScroll/ViewController.swift
    private func initChildConstraints(child : UIView, top : CGFloat) {
        self.addConstraints([
            NSLayoutConstraint(item: child,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0.0),

        NSLayoutConstraint(item: child,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .left,
                           multiplier: 1.0,
                           constant: paddings.left),
        
        NSLayoutConstraint(item: child,
                           attribute: .right,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .right,
                           multiplier: 1.0,
                           constant: -paddings.right)])
        
        
        if previousViewElement == nil {
            self.addConstraint(
                NSLayoutConstraint(item: child,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: .top,
                                   multiplier: 1.0,
                                   constant: paddings.top + top))
        } else {
            self.addConstraint(
                NSLayoutConstraint(item: child,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: previousViewElement,
                                   attribute: .bottom,
                                   multiplier: 1.0,
                                   constant: top))
        }
    }
    
    private func adjustParentBottomConstraint(child : UIView) {
        //if previousViewElement != nil {
        if previousConstraint != nil {
            self.removeConstraint(previousConstraint)
        }
        
        previousConstraint = NSLayoutConstraint(item: child,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .bottom,
                                                multiplier: 1.0,
                                                constant: -paddings.bottom)
        // At this point previousViewElement refers to the last subview, that is the one at the bottom.
        self.addConstraint(previousConstraint)
        //}
    }
    
    public func width(_ width : Int) -> Self {
        helper.width(width)
        return self
    }
    
    // NOTE: At the moment, this only works it gets called before children get added
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        //helper.padding(top: top, left: left, bottom: bottom, right: right)
//        self.layoutMargins =  UIEdgeInsetsMake(20, 10, 20, 10)
        //self.layoutMargins =  UIEdgeInsetsMake(60, 30, 60, 30)
        
        
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
}
