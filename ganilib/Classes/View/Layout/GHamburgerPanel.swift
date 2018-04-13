
import UIKit

open class GHamburgerPanel: UIView, GContainer {
    private var helper: ViewHelper!
//    private let contentView = GVerticalPanel()
//    private let headerView = GVerticalPanel()
//    private let contentView = GScrollView()
//    private let footerView = GVerticalPanel()
    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        initialize()
//    }
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
        
        _ = paddings(t: 0, l: 0, b: 0, r: 0)
    }
    
//    public init() {
//        super.init(frame: .zero)
//        
//        self.helper = ViewHelper(self)
//        
//        self.translatesAutoresizingMaskIntoConstraints = false
//        
////
////        addSubview(headerView)
////        addSubview(contentView)
////        addSubview(footerView)
////        
////                headerView.snp.makeConstraints { make in
////                    make.centerX.equalTo(self)
////                    make.width.equalTo(self)
////        
////                    make.top.equalTo(self)
//////                    make.bottom.equalTo(self)
////                }
////        
////        headerView.snp.makeConstraints { make in
////            make.centerX.equalTo(self)
////            make.width.equalTo(self)
////            
////            make.top.equalTo(self)
////            //                    make.bottom.equalTo(self)
////        }
//        
////        // See https://github.com/zaxonus/AutoLayScroll
////        self.translatesAutoresizingMaskIntoConstraints = false
////        contentView.translatesAutoresizingMaskIntoConstraints = false
////        
////        self.backgroundColor = .green
////        contentView.backgroundColor = .red
////        
////        self.addSubview(contentView)
////        contentView.snp.makeConstraints { make in
////            make.centerX.equalTo(self)
////            make.width.equalTo(self)
////            
////            make.top.equalTo(self)
////            make.bottom.equalTo(self)
////        }
//    }
//    
//    public required init?(coder aDecoder: NSCoder) {
//        fatalError("Not supported")
//    }
    
    public func withViews(_ top: UIView, _ middle: UIView, _ bottom: UIView) -> Self {
        // The hope is this makes things more predictable
        top.translatesAutoresizingMaskIntoConstraints = false
        middle.translatesAutoresizingMaskIntoConstraints = false
        bottom.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(top)
        addSubview(middle)
        addSubview(bottom)
        
        top.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)
            make.top.equalTo(self.snp.topMargin)
//                .offset(paddings.top)
//                .offset(paddings.left)
            
//            make.height.greaterThanOrEqualTo(0)
        }
        
//        middle.snp.contentHuggingVerticalPriority = 1000
        
        middle.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)
            
            make.top.equalTo(top.snp.bottom)
            make.bottom.equalTo(bottom.snp.top)
            
        }
        bottom.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)
            make.bottom.equalTo(self.snp.bottomMargin)
//                .offset(paddings.top)
        }
        
        //        DispatchQueue.main.async {
        self.snp.makeConstraints { make in
            make.rightMargin.greaterThanOrEqualTo(top.snp.right)
//                .offset(self.paddings.bottom)
            make.rightMargin.greaterThanOrEqualTo(middle.snp.right)
            make.rightMargin.greaterThanOrEqualTo(bottom.snp.right)
//                .offset(self.paddings.bottom)
        }
        return self
    }
    
    public func color(bg: UIColor) -> Self {
        self.backgroundColor = bg
        return self
    }
    
    
//    open override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        helper.didMoveToSuperview()
//    }
//    
//    public func clearViews() {
//        contentView.clearViews()
//    }
//    
//    public func addView(_ view: UIView, top : CGFloat? = nil) {
//        contentView.addView(view, top: top)
//    }
//    
//    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
//        _ = contentView.paddings(t: top, l: left, b: bottom, r: right)
//        return self
//    }
    
    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
}
