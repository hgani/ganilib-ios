import UIKit

open class GScreen: UIViewController {
    public let container: GScreenContainer
    
    private var helper : ScreenHelper!
    public var launch : LaunchHelper!
    public var indicator : IndicatorHelper!
    public var nav : NavHelper!
    
    public init(container: GScreenContainer) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    // Don't make this `convenience` so that child class can delegate to it.
    public init() {
        self.container = GScreenContainer(scrollView: GScrollView())
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.container = GScreenContainer(scrollView: GScrollView())
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
        self.nav = NavHelper(navController: GApp.instance.navigationController)
//        self.nav = NavHelper(self)
        
        if let navController = self.navigationController, !navController.navigationBar.isTranslucent {
            // If nav bar is visible and actually consumes space, we want our view to be start just below the bar.
            // Otherwise, we want the view to start right from the top (i.e. status bar)
            self.edgesForExtendedLayout = []
        }

        self.view.backgroundColor = UIColor.white
        
        setupContainer()
    }
    
    private func setupContainer() {
        screenContent().translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(screenContent())
        screenContent().snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view)
            
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.viewWillAppear()
        nav.viewWillAppear()
    }
    
    public func leftMenu(controller: UIViewController) -> Self {
        helper.leftMenu(controller: controller)
        return self
    }
    
    public func leftBarButton(item: UIBarButtonItem) -> Self {
        self.navigationItem.leftBarButtonItem = item
        return self
    }
    
    public func rightBarButton(item: UIBarButtonItem) -> Self {
        self.navigationItem.rightBarButtonItem = item
        return self
    }
    
    public func title(_ title: String) -> Self {
        self.title = title
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
        if let view = screenContent() as? GContainer {
            _ = view.paddings(t: top, l: left, b: bottom, r: right)
        }
        return self
    }
    
    // Don't declare this in an extension or else we'll get compile error
    // See https://stackoverflow.com/questions/44616409/declarations-in-extensions-cannot-override-yet-error-in-swift-4
    open func onRefresh() {
        // To be overridden
    }
}



extension GScreen: ScreenProtocol {
    public var controller: UIViewController {
        get {
            return self
        }
    }
}



import XLPagerTabStrip

extension GScreen: IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: title)
    }
}



public class GScreenContainer: GHamburgerPanel {
    public let header = GVerticalPanel().width(.matchParent)
    private let scrollView: GScrollView?
    private let content: UIView
    public let footer = GVerticalPanel().width(.matchParent)
    
    public init(scrollView: GScrollView) {
        self.content = scrollView.width(.matchParent)
        self.scrollView = scrollView
        
        super.init()
        initialize()
    }
    
    public init(webView: GWebView) {
        self.content = webView.width(.matchParent)
        self.scrollView = nil
        
        super.init()
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("Unsupported operation")
    }
    
    private func initialize() {
        _ = self.withViews(
            header,
            content,
            footer
        )
    }
    
    public func clearViews() {
        scrollView?.clearViews()
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        scrollView?.addView(view, top: top)
    }
}

