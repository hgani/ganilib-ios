
import UIKit

open class GSplitPanel : UIView {
//    private var helper : ViewHelper!
    private var previousViewElement : UIView!
    private var previousConstraint : NSLayoutConstraint!
    private var horizontalPadding : Bool = true
    
    private var paddings = UIEdgeInsetsMake(0, 0, 0, 0)
    
    public init(horizontalPadding : Bool = true) {
        super.init(frame: .zero)
        
//        self.helper = ViewHelper(self)
        self.horizontalPadding = horizontalPadding
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func withViews(_ left: UIView, _ right: UIView) -> Self {
        // The hope is this makes things more predictable
        left.translatesAutoresizingMaskIntoConstraints = false
        right.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(left)
        addSubview(right)
        
        left.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.left.equalTo(self)
        }
        right.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self)
            make.right.equalTo(self)
        }
        
        DispatchQueue.main.async {
            self.snp.makeConstraints { (make) -> Void in
                if left.frame.height > right.frame.height {
                    make.bottom.equalTo(left)
                }
                else {
                    make.bottom.equalTo(right)
                }
            }
        }
        
        return self
    }
    
//    public func width(_ width : Int) -> Self {
//        helper.width(width)
//        return self
//    }
//    
//    // NOTE: At the moment, this only works it gets called before children get added
//    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
//        //helper.padding(top: top, left: left, bottom: bottom, right: right)
//        //        self.layoutMargins =  UIEdgeInsetsMake(20, 10, 20, 10)
//        //self.layoutMargins =  UIEdgeInsetsMake(60, 30, 60, 30)
//        
//        
//        let orig = self.paddings
//        
//        let top = top ?? orig.top
//        let left = left ?? orig.left
//        let bottom = bottom ?? orig.bottom
//        let right = right ?? orig.right
//        
//        self.paddings = UIEdgeInsetsMake(top, left, bottom, right)
//        return self
//    }
//    
    public func color(bg: UIColor) -> Self {
        self.backgroundColor = bg
        return self
    }
}
