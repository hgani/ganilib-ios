#if INCLUDE_EUREKA

    import Eureka
    import UIKit

    open class GFormScreen: FormViewController {
        private var helper: ScreenHelper!
        public var launch: LaunchHelper!
        public var indicator: IndicatorHelper!
        public var nav: NavHelper!
        public var previous: ScreenProtocol?

        public lazy var refresher: GRefreshControl = {
            GRefreshControl().onValueChanged {
                self.onRefresh()
            }
        }()

        public init() {
            super.init(nibName: nil, bundle: nil)
        }

        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        open override func viewDidLoad() {
            super.viewDidLoad()

            helper = ScreenHelper(self)
            launch = LaunchHelper(self)
            indicator = IndicatorHelper(self)
            nav = NavHelper(self)
        }

        public func appendRefresher() {
            tableView.addSubview(refresher)

            // Eureka-specific requirements
            refresher.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(4)
                make.centerX.equalTo(tableView!)
            }
        }

        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            helper.viewWillAppear()
        }

        open override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            // See https://stackoverflow.com/questions/8228411/detecting-when-the-back-button-is-pressed-on-a-navbar
            if isMovingFromParentViewController || isBeingDismissed {
                onPopping()
            }
        }

        open func onPopping() {
            // To be overridden
        }

        @discardableResult
        public func leftMenu(controller: GScreen) -> Self {
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

        public func done() {
            // Ends chaining
        }

        // Don't declare this in an extension or else we'll get compile error
        // See https://stackoverflow.com/questions/44616409/declarations-in-extensions-cannot-override-yet-error-in-swift-4
        open func onRefresh() {
            // To be overridden
        }

        public func values() -> GParams {
            let wrapped = form.values(includeHidden: true)
            var unwrapped = GParams()

            for (key, value) in wrapped {
                unwrapped[key] = value
            }

            return unwrapped
        }

        public func setupHeaderFooter(height: Int? = nil, populate: @escaping (GHeaderFooterView) -> Void) -> HeaderFooterView<GHeaderFooterView> {
            var headerFooter = HeaderFooterView<GHeaderFooterView>(.class)
            headerFooter.height = {
                if let value = height {
                    return CGFloat(value)
                }
                return UITableViewAutomaticDimension
            }
            headerFooter.onSetupView = { view, _ in
                populate(view.clear())
            }
            return headerFooter
        }
    }

    extension GFormScreen: ScreenProtocol {
        public var controller: UIViewController {
            return self
        }
    }

#endif
