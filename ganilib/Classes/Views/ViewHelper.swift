
import UIKit
import SnapKit


open class ViewHelper {
    private let view: UIView
    
    public init(_ view: UIView) {
        self.view = view
    }
    
    public func width(_ width : Int) {
        view.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(width)
        }
    }
    
    public func height(_ height : Int) {
        view.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(height)
        }
    }
}
