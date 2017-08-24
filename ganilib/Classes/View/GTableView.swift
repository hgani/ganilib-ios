
import UIKit

open class GTableView : UITableView {
    private var helper : ViewHelper!
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.helper = ViewHelper(self)
    }

//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.helper = ViewHelper(self)
//    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func color(bg : UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    public func source(_ source: UITableViewDataSource) -> Self {
        self.dataSource = source
        return self
    }
    
    public func register(_ type: GTableViewCell.Type) -> Self {
        register(type.nib(), forCellReuseIdentifier: type.reuseIdentifier())
        return self
    }
    
    public func reload() -> Self {
        reloadData()
        return self
    }
    
    public func height(_ height : Int) -> Self {
        helper.height(height)
        return self
    }
}



//public protocol Reusable {
//    static func nibName() -> String
//    static func reuseIdentifier() -> String
//}
//
//public extension Reusable {
//
//    static func nibName() -> String {
//        return String(describing: self)
//    }
//
//    static func reuseIdentifier() -> String {
//        return String(describing: self)
//    }
//
//    static func nib() -> UINib {
//        return UINib(nibName: nibName(), bundle: nil)
//    }
//
//}


open class GTableViewCell: UITableViewCell {
    public init() {
        super.init(style: .default, reuseIdentifier: type(of: self).nibName())        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func nibName() -> String {
        return String(describing: self)
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: nibName(), bundle: nil)
    }

}
