
import UIKit

open class GScreen: UIViewController, ScreenProtocol {
//    public let container = GScrollView()
    public let container = GScreenContainer()
    
    private var helper : ScreenHelper!
    public var launch : LaunchHelper!
    public var indicator : IndicatorHelper!
    public var nav : NavHelper!
    
//    public var previous: ScreenProtocol?
    
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
        
        Log.t("viewDidLoad1 \(self.navigationController!.navigationBar.isTranslucent)")
        
        if !self.navigationController!.navigationBar.isTranslucent {
            // If nav bar is visible and actually consumes space, we want our view to be start just below the bar.
            // Otherwise, we want the view to start right from the top (i.e. status bar)
            self.edgesForExtendedLayout = []
        }

        self.view.backgroundColor = UIColor.white
        
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
    
    public func leftMenu(controller: UITableViewController) -> Self {
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

public class GScreenContainer: GHamburgerPanel {
    public let header = GVerticalPanel().width(.matchParent)
    private let content = GScrollView().width(.matchParent)
    public let footer = GVerticalPanel().width(.matchParent)
//        .height(50)
    
    public override init() {
        super.init()
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        _ = self.withViews(
            header,
            content,
            footer
        )
    }
    
    public func clearViews() {
        content.clearViews()
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        content.addView(view, top: top)
    }
}
