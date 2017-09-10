
import UIKit

open class GImageView : UIImageView {
    private var helper : ViewHelper!
    private var onClick : (() -> Void)?
    
    public init() {
        super.init(frame: .zero)
        initialize()
        
//        self.helper = ViewHelper(self)
//        
        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
//        _ = self.padding(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func width(_ width : Int) -> Self {
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
    
    public func color(bg : UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }

    public func namedImage(_ name: String) -> Self {
        self.image = UIImage(named: name)
        return self
    }
    
    public func adjustHeight() {
        if let i = image {
            layoutIfNeeded();
            
            let ratio = i.size.width / i.size.height;
            let height = self.frame.width / ratio
            
            NSLog("Adjusting to height: \(height)")
            
            self.snp.makeConstraints { (make) -> Void in
                make.height.equalTo(height)
            }
        }
    }
}
