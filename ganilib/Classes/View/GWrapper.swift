
import UIKit

open class GWrapper : UIView {
    private var helper : ViewHelper!
    private var child : UIView!
    
    public init(_ child : UIView, gravity : GWrapperGravity = .center) {
        super.init(frame: .zero)
        
        self.helper = ViewHelper(self)
        self.child = child
        
        addSubview(child)
        
        child.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            
            switch gravity {
            case .left:
                make.left.equalTo(0)
                break
            case .right:
                make.right.equalTo(0)
                break
            case .center:
                make.centerX.equalTo(self)
            }
        }
        
        snp.makeConstraints { (make) -> Void in
            make.height.equalTo(child)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func height(_ height : Int) -> Self {
        helper.height(height)
        return self
    }
//    public func width(_ width : Int) -> GWrapper {
//        child.snp.makeConstraints { (make) -> Void in
//            make.width.equalTo(width)
//        }
//        return self
//    }
    
    
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public enum GWrapperGravity {
        case center
        case left
        case right
    }
}
