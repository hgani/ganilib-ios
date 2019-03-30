open class JsonView {
    public let spec: Json
    public unowned let screen: GScreen

    // This constructor allows dynamic instantiation of child classes.
    public required init(_ spec: Json, _ screen: GScreen) {
        self.spec = spec
        self.screen = screen
    }

    private func initGenericAttributes(backend: UIView) {
        if let view = backend as? UIView & IView {
            initBackgroundColor(view)
            initWidth(view)
            initHeight(view)
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
            view.color(bg: color(from: str))
        }
    }

    private func initWidth(_ view: IView) {
        if let width = spec["width"].presence {
            if let val = width.string {
                switch val {
                case "wrapContent":
                    view.width(.wrapContent)
                case "matchParent":
                    view.width(.matchParent)
                default:
                    view.width(width.intValue)
                }
            } else if let val = width.int {
                view.width(width.intValue)
            }
        }
    }

    private func initHeight(_ view: UIView & IView) {
        if let height = spec["height"].presence {
            if let val = height.string {
                switch val {
                case "wrapContent":
                    view.height(.wrapContent)
                case "matchParent":
                    view.height(.matchParent)
                    // Needed for high hugging views (e.g. UILabel, UIButton) in a stretchable panel, e.g.
                    // the middle part of a hamburger panel.
                    ViewHelper.minimumHugging(view: view, axis: .vertical)
                default:
                    view.height(height.intValue)
                }
            } else if let val = height.int {
                view.height(height.intValue)
            }
        }
    }

    private func initPadding(_ view: IView) {
        let padding = spec["padding"]
        view.paddings(top: padding["top"].float, left: padding["left"].float, bottom: padding["bottom"].float, right: padding["right"].float)
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
