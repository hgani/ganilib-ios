import UIKit

open class GScreen: UIViewController {
    public let scrollPanel = GScrollPanel().width(.matchParent)
    public let container = GScreenContainer()

    private var helper: ScreenHelper!
    public var launch: LaunchHelper!
    public var indicator: IndicatorHelper!
    public var nav: NavHelper!

    public lazy var refresher: GRefreshControl = {
        GRefreshControl().onValueChanged {
            self.onRefresh()
        }
    }()

    // Don't make this `convenience` so that child class can delegate to it.
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Useful for when we don't have one global nav controller.
    public func localNavController(_ navController: UINavigationController) {
        nav = NavHelper(navController: navController)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        helper = ScreenHelper(self)
        launch = LaunchHelper(self)
        indicator = IndicatorHelper(self)
        if nav == nil {
            nav = NavHelper(navController: GApp.instance.navigationController)
        }

        if let navController = self.navigationController, !navController.navigationBar.isTranslucent {
            // If nav bar is visible and actually consumes space, we want our view to be start just below the bar.
            // Otherwise, we want the view to start right from the top (i.e. status bar)
            edgesForExtendedLayout = []
        }

        view.backgroundColor = UIColor.white

        setupContainer()
    }

    private func setupContainer() {
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        container.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(view)

            make.top.equalTo(view)
            make.bottom.equalTo(view)
        }
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.viewWillAppear()
        nav.viewWillAppear()
    }

    @discardableResult
    public func leftMenu(controller: UIViewController) -> Self {
        helper.leftMenu(controller: controller)
        return self
    }

    @discardableResult
    public func leftBarButton(item: UIBarButtonItem) -> Self {
        navigationItem.leftBarButtonItem = item
        return self
    }

    @discardableResult
    public func rightBarButton(item: UIBarButtonItem) -> Self {
        navigationItem.rightBarButtonItem = item
        return self
    }

    @discardableResult
    public func rightBarButtons(items: [UIBarButtonItem]) -> Self {
        navigationItem.rightBarButtonItems = items
        return self
    }

    public func title(_ title: String) -> Self {
        self.title = title
        return self
    }

    public func done() {
        // Ends chaining
    }

    public func color(bg: UIColor) -> Self {
        view.backgroundColor = bg
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
        return self
    }
}

#if INCLUDE_UILIBS

    import XLPagerTabStrip

    extension GScreen: IndicatorInfoProvider {
        public func indicatorInfo(for _: PagerTabStripViewController) -> IndicatorInfo {
            return IndicatorInfo(title: title)
        }
    }

#endif

public class GScreenContainer: GHamburgerPanel {
    public let header = GVerticalPanel().width(.matchParent)
    public let content = GVerticalPanel().width(.matchParent)
    public let footer = GVerticalPanel().width(.matchParent)

    public override init() {
        super.init()
        initialize()
    }

    public required init?(coder _: NSCoder) {
        fatalError("Unsupported operation")
    }

    private func initialize() {
        _ = withViews(
            header,
            content,
            footer
        )
//        content.snp.makeConstraints { make in
//            make.right.equalTo(self.snp.rightMargin)
//        }
    }
}
