
import UIKit

open class GScreen : UIViewController {
    private let scrollView = UIScrollView()
    public let contentView = GVerticalPanel()
    private var helper : ScreenHelper!
    public var launch : LaunchHelper!
    public var indicator : IndicatorHelper!
    public var nav : NavHelper!
    
    private var previousViewElement:UIView!
    
    /*
     init() {
     super.init(nibName: nil, bundle: nil)
     initialize()
     }
     
     required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     initialize()
     }
     
     private func initialize() {
     }
     */
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.helper = ScreenHelper(self)
        self.launch = LaunchHelper(self)
        self.indicator = IndicatorHelper(self)
        self.nav = NavHelper(self)
                
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.white
        
        // See https://github.com/zaxonus/AutoLayScroll
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
                
        self.view.addConstraints([
            NSLayoutConstraint(item: scrollView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: scrollView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .width,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: scrollView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: scrollView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0.0)])
        
        scrollView.addConstraints([
            NSLayoutConstraint(item: contentView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: scrollView,
                               attribute: .centerX,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: contentView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: scrollView,
                               attribute: .width,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: contentView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: scrollView,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0.0),
            NSLayoutConstraint(item: contentView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: scrollView,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0.0)])
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        contentView.addView(view, top: top)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.viewWillAppear()
        nav.viewWillAppear()
    }
    
    public func setupLeftMenuButton() {
        helper.setupLeftMenuButton()
    }
    
    public func color(bg: UIColor) -> Self {
        self.view.backgroundColor = bg
        return self
    }
    
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        _ = self.contentView.padding(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
