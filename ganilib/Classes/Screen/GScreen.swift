
import UIKit

open class GScreen : UIViewController, ScreenProtocol {
    public let container = GScrollView()
    
    private var helper : ScreenHelper!
    public var launch : LaunchHelper!
    public var indicator : IndicatorHelper!
    public var nav : NavHelper!
    
    public var previous: ScreenProtocol?
    
//    public convenience init() {
////        super.init(nibName: nil, bundle: nil)
//        self.init(container: GScrollView())
//    }
    
//    public init(container: UIView) {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func screenContent() -> UIView {
        return container
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.helper = ScreenHelper(self)
        self.launch = LaunchHelper(self)
        self.indicator = IndicatorHelper(self)
        self.nav = NavHelper(self)
                
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.white

        self.view.addSubview(screenContent())
        screenContent().snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        // See https://github.com/zaxonus/AutoLayScroll
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        
//        scrollView.backgroundColor = .red
//        contentView.backgroundColor = .green
//        
//        self.view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
        
//        self.view.addConstraints([
//            NSLayoutConstraint(item: scrollView,
//                               attribute: .centerX,
//                               relatedBy: .equal,
//                               toItem: self.view,
//                               attribute: .centerX,
//                               multiplier: 1.0,
//                               constant: 0.0),
//            NSLayoutConstraint(item: scrollView,
//                               attribute: .width,
//                               relatedBy: .equal,
//                               toItem: self.view,
//                               attribute: .width,
//                               multiplier: 1.0,
//                               constant: 0.0),
//            NSLayoutConstraint(item: scrollView,
//                               attribute: .top,
//                               relatedBy: .equal,
//                               toItem: self.view,
//                               attribute: .top,
//                               multiplier: 1.0,
//                               constant: 0.0),
//            NSLayoutConstraint(item: scrollView,
//                               attribute: .bottom,
//                               relatedBy: .equal,
//                               toItem: self.view,
//                               attribute: .bottom,
//                               multiplier: 1.0,
//                               constant: 0.0)])
        
        
//        scrollView.snp.makeConstraints { make in
//            make.centerX.equalTo(view)
//            make.width.equalTo(view)
//            
//            make.top.equalTo(view)
//            make.bottom.equalTo(view)
//        }
        
//        contentView.snp.makeConstraints { make in
//            make.centerX.equalTo(scrollView)
//            make.width.equalTo(scrollView)
//            
//            make.top.equalTo(scrollView)
//            make.bottom.equalTo(scrollView)
//        }
        
//        scrollView.addConstraints([
//            NSLayoutConstraint(item: contentView,
//                               attribute: .centerX,
//                               relatedBy: .equal,
//                               toItem: scrollView,
//                               attribute: .centerX,
//                               multiplier: 1.0,
//                               constant: 0.0),
//            NSLayoutConstraint(item: contentView,
//                               attribute: .width,
//                               relatedBy: .equal,
//                               toItem: scrollView,
//                               attribute: .width,
//                               multiplier: 1.0,
//                               constant: 0.0),
//            NSLayoutConstraint(item: contentView,
//                               attribute: .top,
//                               relatedBy: .equal,
//                               toItem: scrollView,
//                               attribute: .top,
//                               multiplier: 1.0,
//                               constant: 0.0),
//            NSLayoutConstraint(item: contentView,
//                               attribute: .bottom,
//                               relatedBy: .equal,
//                               toItem: scrollView,
//                               attribute: .bottom,
//                               multiplier: 1.0,
//                               constant: 0.0)])
        
        //_ = padding(top: UIApplication.shared.statusBarFrame.height)
    }
    
    
//    public func clearViews() {
////        contentView.clearViews()
//    }
//    
//    public func addView(_ view: UIView, top : CGFloat? = nil) {
////        contentView.addView(view, top: top)
//    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.viewWillAppear()
        nav.viewWillAppear()
    }
    
    // Deprecated
    public func setupLeftMenuButton() {
        helper.setupLeftMenuButton()
    }
    
    public func leftMenu(controller: UITableViewController) -> Self {
        helper.leftMenu(controller: controller)
        return self
    }
    
    public func end() {
        // Ends chaining
    }
    
    public func color(bg: UIColor) -> Self {
        self.view.backgroundColor = bg
        return self
    }
    
    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
        _ = container.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    open func onRefresh() {
        // To be overridden
    }
}
