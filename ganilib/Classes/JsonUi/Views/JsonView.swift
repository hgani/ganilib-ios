open class JsonView {
    public let spec: Json
    public unowned let screen: GScreen

    // This constructor allows dynamic instantiation of child classes.
    public required init(_ spec: Json, _ screen: GScreen) {
        self.spec = spec
        self.screen = screen
    }

    private func initGenericAttributes(backend: UIView) {
        if let view = backend as? IView {
            initBackgroundColor(view)
            initWidth(view)
            initPadding(view)
        }
    }

    private func color(from str: String) -> UIColor {
        switch str {
        case "transparent":
            return UIColor.clear
        default:
            return UIColor(hex: str)
        }
    }

    private func initBackgroundColor(_ view: IView) {
        if let str = spec["backgroundColor"].string {
            _ = view.color(bg: color(from: str))
        }
    }

    private func initWidth(_ view: IView) {
        if let str = spec["width"].string {
            switch str {
            case "wrapContent":
                _ = view.width(.wrapContent)
            case "matchParent":
                _ = view.width(.matchParent)
            default:
                _ = view.width(spec["width"].intValue)
            }
        }
    }

    private func initPadding(_ view: IView) {
        let padding = spec["padding"]
        _ = view.paddings(t: padding["top"].float, l: padding["left"].float, b: padding["bottom"].float, r: padding["right"].float)
    }

    open func initView() -> UIView {
        fatalError("Need implementation")
    }

    func createView() -> UIView {
        let view = initView()
        initGenericAttributes(backend: view)
        return view
    }

    static func create(spec: Json, screen: GScreen) -> JsonView? {
        if let klass = JsonUi.loadClass(name: spec["view"].stringValue, type: JsonView.self) as? JsonView.Type {
            return klass.init(spec, screen)
        }
        GLog.w("Failed loading view: \(spec)")
        return nil
    }
}
