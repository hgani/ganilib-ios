
import UIKit
import Kingfisher

open class GImageView : UIImageView {
    private var helper : ViewHelper!
    private var onClick : ((GImageView) -> Void)?
    
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
    
    // Needed for helper.width() and helper.height()
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

    public func image(_ image: UIImage) -> Self {
        self.image = image
        return self
    }
    
    // Deprecated
//    public func namedImage(_ name: String) -> Self {
//        self.image = UIImage(named: name)
//        return self
//    }
    
    public func source(name: String) -> Self {
        return source(image: UIImage(named: name))
    }
    
    public func source(image: UIImage?) -> Self {
        self.image = image
        return self
    }
    
    public func source(url: URL?, placeholder: UIImage? = nil) -> Self {
        self.kf.setImage(with: url, placeholder: placeholder)
        return self
    }
    
    public func source(url: String, placeholder: UIImage? = nil) -> Self {
        return source(url: URL(string: url), placeholder: placeholder)
    }
    
    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }
    
    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    open func onClick(_ command: @escaping (GImageView) -> Void) -> Self {
        self.onClick = command
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(performClick))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(singleTap)
        return self
    }
    
    @objc open func performClick() {
        if let callback = self.onClick {
            callback(self)
        }
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
    
    public func end() {
        // End chaining initialisation
    }
}
