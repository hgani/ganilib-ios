open class JsonView {
    public let spec: Json
    public let screen: GScreen
    
    // This constructor allows dynamic instantiation of child classes.
    required public init(_ spec: Json, _ screen: GScreen) {
        self.spec = spec
        self.screen = screen
    }
    
    private func initGenericAttributes(backend: UIView) {
        if let view = backend as? IView {
            if let hexColor = spec["backgroundColor"].string {
                _ = view.color(bg: UIColor(hex: hexColor))
            }
        }
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
