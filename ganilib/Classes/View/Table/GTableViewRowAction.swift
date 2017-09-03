
import UIKit

open class GTableViewRowAction: UITableViewRowAction {
//    private var helper: ViewHelper!
//    
//    public override init(frame: CGRect, style: UITableViewStyle) {
//        super.init(frame: frame, style: style)
//        
//        self.helper = ViewHelper(self)
//    }
//
//    required public init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
}
