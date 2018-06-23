
import UIKit

open class GControl: UIControl {
    private var helper: ControlHelper<GControl>!

    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ControlHelper(self)
    }
    
    // Needed for helper.width() and helper.height()
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
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
    
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    open func onClick(_ command: @escaping (GControl) -> Void) -> Self {
        helper.onClick(command)
        return self
    }
    
    public func withView(_ child: UIView) -> Self {
        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(child)
        
        self.snp.makeConstraints { make in
//            switch horizontalAlign {
//            case .center: make.centerX.equalTo(child)
//            case .right: make.rightMargin.equalTo(child.snp.right)
//            case .left: make.leftMargin.equalTo(child.snp.left)
//            }
//
//            //            make.centerX.equalTo(child)
//            make.centerY.equalTo(child)
            
//            // So that it is at least the size of the child
//            make.width.greaterThanOrEqualTo(child)
//            make.height.greaterThanOrEqualTo(child)
            
            make.left.equalTo(child)
            make.top.equalTo(child)
            
            make.width.greaterThanOrEqualTo(child)
            make.height.greaterThanOrEqualTo(child)
        }
        return self
    }
    
//    public func withView(_ child: UIView) -> Self {
//        // The hope is this makes things more predictable
//        child.translatesAutoresizingMaskIntoConstraints = false
//        
//        addSubview(child)
//        
//        self.snp.makeConstraints { make in
//            switch horizontalAlign {
//            case .center: make.centerX.equalTo(child)
//            case .right: make.rightMargin.equalTo(child.snp.right)
//            case .left: make.leftMargin.equalTo(child.snp.left)
//            }
//            
//            //            make.centerX.equalTo(child)
//            make.centerY.equalTo(child)
//        }
//        return self
//    }
}
