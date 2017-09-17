
import UIKit

open class GVerticalPanel: UIView {
    private var helper: ViewHelper!
    private var previousViewElement: UIView!
    private var previousConstraint: NSLayoutConstraint!
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
        
        _ = paddings(t: 0, l: 0, b: 0, r: 0)
        
         addInitialBottomConstraint()
    }
    
    private func addInitialBottomConstraint() {
        previousConstraint = NSLayoutConstraint(item: self,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .top,
                                                multiplier: 1.0,
                                                constant: 0.0)
        previousConstraint.priority = 900  // Lower priority than fixed height
        self.addConstraint(previousConstraint)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func clearViews() {
        // Remove it explicitly because it's not necessarily related to a  child view, thus won't be removed
        // as part of view.removeFromSuperview()
        self.removeConstraint(previousConstraint)
        addInitialBottomConstraint()
        
        previousViewElement = nil
//        previousConstraint = nil

        for view in subviews {
            view.removeFromSuperview()
        }
        
//        addInitialBottomConstraint()
    }
    
    public func addView(_ child : UIView, top : CGFloat? = nil) {
        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false
        
        super.addSubview(child)
        initChildConstraints(child: child, top: top ?? 0)
        adjustSelfConstraints(child: child)
        
        previousViewElement = child
    }
    
    public func append(_ child : UIView, top : CGFloat? = nil) -> Self {
        addView(child, top: top)
        return self
    }
    
    // See https://github.com/zaxonus/AutoLayScroll/blob/master/AutoLayScroll/ViewController.swift
    private func initChildConstraints(child : UIView, top : CGFloat) {
        child.snp.makeConstraints { make in
            if previousViewElement == nil {
                  // For some reason there seems to be a negative offset so we need to add a magic number, i.e. 8
//                make.topMargin.equalTo(self).offset(top + 8)
//                make.top.equalTo(self).offset(top)
//                    .offset(helper.paddings.top + top)
                
                make.top.equalTo(self.snp.topMargin).offset(top)
            }
            else {
                make.top.equalTo(previousViewElement.snp.bottom).offset(top)
                
//                make.top.equalTo(previousViewElement.snp.bottom)
//                    .offset(top)
            }
            
            make.left.equalTo(self.snp.leftMargin)
//            make.left.equalTo(self)
//                .offset(helper.paddings.left)
        }
    }
    
    private func adjustSelfConstraints(child : UIView) {
        self.snp.makeConstraints { (make) -> Void in
//            make.bottom.greaterThanOrEqualTo(child).offset(paddings.bottom)
            
            make.rightMargin.greaterThanOrEqualTo(child.snp.right)
            
//            make.right.greaterThanOrEqualTo(child)
//                .offset(helper.paddings.right)
        }
        
        if !helper.shouldHeightMatchParent() {
//            if previousConstraint != nil {
            self.removeConstraint(previousConstraint)
//            }
            
            
            previousConstraint = NSLayoutConstraint(item: child,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .bottomMargin,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
            previousConstraint.priority = 900

            // At this point previousViewElement refers to the last subview, that is the one at the bottom.
            self.addConstraint(previousConstraint)
        }
    }
    
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
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
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
//    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
////        let orig = self.paddings
////        
////        let top = top ?? orig.top
////        let left = left ?? orig.left
////        let bottom = bottom ?? orig.bottom
////        let right = right ?? orig.right
////        
////        self.paddings = UIEdgeInsetsMake(top, left, bottom, right)
//        
//        
//        let orig = self.layoutMargins
//        
//        let top = top ?? orig.top
//        let left = left ?? orig.left
//        let bottom = bottom ?? orig.bottom
//        let right = right ?? orig.right
//        
//        self.layoutMargins = UIEdgeInsetsMake(top, left, bottom, right)
//        
//        return self
//    }
    
    public func color(bg: UIColor) -> Self {
        self.backgroundColor = bg
        return self
    }
    
    open override func addSubview(_ view: UIView) {
        fatalError("Use addView() instead")
    }
}
