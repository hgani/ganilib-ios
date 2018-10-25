#if INCLUDE_UILIBS

    import XLPagerTabStrip

    public typealias GPagerTabStripSettings = ButtonBarPagerTabStripSettings

    open class GPagerTabStrip: ButtonBarPagerTabStripViewController {
        private let controllers: [UIViewController]

        public init(controllers: [UIViewController]) {
            self.controllers = controllers
            super.init(nibName: nil, bundle: nil)
        }

        public required init?(coder _: NSCoder) {
            fatalError("Unsupported")
        }

        public final override func viewControllers(for _: PagerTabStripViewController) -> [UIViewController] {
            return controllers
        }

        public final override func viewDidLoad() {
            // Should be called before viewDidLoad()
            initSettings(&settings)

            super.viewDidLoad()
        }

        open func initSettings(_: inout GPagerTabStripSettings) {
            // To be overridden
        }
    }

#endif
