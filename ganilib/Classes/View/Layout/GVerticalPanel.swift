
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
        previousConstraint.priority = UILayoutPriority(rawValue: 900)  // Lower priority than fixed height
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

        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    public func addView(_ child : UIView, top : CGFloat? = nil) {
        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false
        
        super.addSubview(child)
        initChildConstraints(child: child, top: top ?? 0)
        adjustSelfConstraints(child: child)
        
        previousViewElement = child
    }
    
    public func clear() -> Self {
        clearViews()
        return self
    }
    
    public func append(_ child : UIView, top : CGFloat? = nil) -> Self {
        addView(child, top: top)
        return self
    }
    
    // See https://github.com/zaxonus/AutoLayScroll/blob/master/AutoLayScroll/ViewController.swift
    private func initChildConstraints(child : UIView, top : CGFloat) {
        child.snp.makeConstraints { make in
            if previousViewElement == nil {
                make.top.equalTo(self.snp.topMargin).offset(top)
            }
            else {
                make.top.equalTo(previousViewElement.snp.bottom).offset(top)
            }
            
            make.left.equalTo(self.snp.leftMargin)
        }
    }
    
    private func adjustSelfConstraints(child : UIView) {
        self.snp.makeConstraints { (make) -> Void in
            make.rightMargin.greaterThanOrEqualTo(child.snp.right)
        }
        
        if !helper.shouldHeightMatchParent() {
            self.removeConstraint(previousConstraint)
            
            previousConstraint = NSLayoutConstraint(item: child,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .bottomMargin,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
            previousConstraint.priority = UILayoutPriority(rawValue: 900)

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
    
    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    public func color(bg: UIColor) -> Self {
        self.backgroundColor = bg
        return self
    }
    
    open override func addSubview(_ view: UIView) {
        fatalError("Use addView() instead")
    }
    
    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }
    
    public func done() {
        // Ends chaining
    }
}
