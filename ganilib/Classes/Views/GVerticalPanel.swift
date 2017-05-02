
import UIKit

open class GVerticalPanel : UIView {
    private var previousViewElement : UIView!
    private var previousConstraint : NSLayoutConstraint!
    private var defaultTop : CGFloat = 0.0
    
    public var defaultGap : CGFloat {
        set { defaultTop = newValue }
        get { return defaultTop }
    }
    
    public func addView(_ view : UIView, top : CGFloat? = nil, wrap : Bool = false) {
        var child = view
        
        if wrap {
            let container = UIView()
            container.addSubview(view)
            
            view.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(0)
                make.centerX.equalTo(container)
            }
            
            container.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(view)
            }
            
            child = container
        }
        
        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(child)
        initChildConstraints(child: child, top: top ?? defaultTop)
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
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .width,
                               multiplier: 6/7,
                               constant: 0.0)])
        
        if previousViewElement == nil {
            self.addConstraint(
                NSLayoutConstraint(item: child,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: .top,
                                   multiplier: 1.0,
                                   constant: top))
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
                                                constant: -defaultTop)
        // At this point previousViewElement refers to the last subview, that is the one at the bottom.
        self.addConstraint(previousConstraint)
        //}
    }
}
