
import UIKit

open class GAligner: UIView {
    private var helper: ViewHelper!
    
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
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func withView(_ child: UIView) -> Self {
        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(child)
                
        self.snp.makeConstraints { make in
            make.centerX.equalTo(child)
            make.centerY.equalTo(child)

            // So that it is at least the size of the child
            make.width.greaterThanOrEqualTo(child)
            make.height.greaterThanOrEqualTo(child)
        }
        return self
    }
    
    public func width(_ width : Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func height(_ height : Int) -> Self {
        helper.height(height)
        return self
    }
    
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }
    
    public func height(_ height: LayoutSize) -> Self {
        helper.width(height)
        return self
    }

    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public enum GAlignerGravity {
        case center
        case centerVertical
        case centerHorizontal
//        case left
//        case right
    }
}
