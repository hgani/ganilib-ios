
import UIKit

open class GScrollView: UIScrollView {
    private var helper: ViewHelper!
    private let contentView = GVerticalPanel()
    
    public init(horizontalPadding : Bool = true) {
        super.init(frame: .zero)
        
        self.helper = ViewHelper(self)
        
        // See https://github.com/zaxonus/AutoLayScroll
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    public func clearViews() {
        contentView.clearViews()
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        contentView.addView(view, top: top)
    }
    
    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
        _ = contentView.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
}
