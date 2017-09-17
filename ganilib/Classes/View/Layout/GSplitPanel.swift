
import UIKit

open class GSplitPanel : UIView {
    private var helper : ViewHelper!
    private var previousViewElement : UIView!
    private var previousConstraint : NSLayoutConstraint!
//    private var paddings = UIEdgeInsetsMake(0, 0, 0, 0)
    
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
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func withViews(_ left: UIView, _ right: UIView) -> Self {
        // The hope is this makes things more predictable
        left.translatesAutoresizingMaskIntoConstraints = false
        right.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(left)
        addSubview(right)
        
        left.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
//                .offset(paddings.top)
            make.left.equalTo(self.snp.leftMargin)
//                .offset(paddings.left)
        }
        right.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
//                .offset(paddings.top)
            make.right.equalTo(self.snp.rightMargin)
//                .offset(paddings.right)
        }
        
//        DispatchQueue.main.async {
            self.snp.makeConstraints { make in
                make.bottomMargin.greaterThanOrEqualTo(left.snp.bottom)
//                    .offset(self.paddings.bottom)
                make.bottomMargin.greaterThanOrEqualTo(right.snp.bottom)
//                    .offset(self.paddings.bottom)
//                    .priority(240)
            }
//        }
        
        return self
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
    
//    // NOTE: At the moment, this only works it gets called before children get added
//    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
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
    
    public func color(bg: UIColor) -> Self {
        self.backgroundColor = bg
        return self
    }
}
