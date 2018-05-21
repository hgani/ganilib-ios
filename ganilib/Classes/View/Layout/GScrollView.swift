
import UIKit

open class GScrollView: UIScrollView {
    private var helper: ViewHelper!
    private let contentView = GVerticalPanel()
    
    public init() {
        super.init(frame: .zero)
        
        self.helper = ViewHelper(self)
        
        // See https://github.com/zaxonus/AutoLayScroll
//        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
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
    
    public func width(weight: Float) -> Self {
        helper.width(weight: weight)
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
    
    public func clearViews() {
        contentView.clearViews()
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        contentView.addView(view, top: top)
    }
    
    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        _ = contentView.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
//    public func test() {
//        contentView.height(300)
//    }
    
}
