import XLPagerTabStrip

public typealias GPagerTabStripSettings = ButtonBarPagerTabStripSettings

open class GPagerTabStrip: ButtonBarPagerTabStripViewController {
    private let controllers: [UIViewController]
    
    public init(controllers: [UIViewController]) {
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override final public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return controllers
    }
    
    override final public func viewDidLoad() {
        // Should be called before viewDidLoad()
        initSettings(&settings)
        
        super.viewDidLoad()
    }
    
    open func initSettings(_ settings: inout GPagerTabStripSettings) {
        // To be overridden
    }
}
