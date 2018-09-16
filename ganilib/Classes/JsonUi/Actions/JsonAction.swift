open class JsonAction {
    public let spec: Json
    public let screen: GScreen
    
    required public init(_ spec: Json, _ screen: GScreen) {
        self.spec = spec
        self.screen = screen
    }
    
    public final func execute() {
        if !silentExecute() {
            GLog.w("Invalid action spec: \(spec)")
        }
    }
    
    open func silentExecute() -> Bool {
        fatalError("Need implementation")
    }
    
    private static func create(spec: Json, screen: GScreen) -> JsonAction? {
        if let klass = JsonUi.loadClass(name: spec["action"].stringValue, type: JsonAction.self) as? JsonAction.Type {
            return klass.init(spec, screen)
        }
        GLog.w("Failed loading action: \(spec)")
        return nil
    }

    public static func executeAll(spec: Json, screen: GScreen) {
        create(spec: spec, screen: screen)?.execute()

//        for actionSpec in spec.arrayValue {
//            create(spec: actionSpec, screen: screen)?.execute()
//        }
    }
}
