
import UIKit

open class GWrapper : UIView {
    init(_ child : UIView, gravity : GWrapperGravity = .center) {
        super.init(frame: .zero)
        
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
    
    enum GWrapperGravity {
        case center
        case left
        case right
    }
}
