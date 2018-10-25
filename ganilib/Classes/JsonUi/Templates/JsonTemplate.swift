open class JsonTemplate {
    public let tableView: GTableView
    public let spec: Json
    public let screen: GScreen

    // This constructor allows dynamic instantiation of child classes.
    public required init(_ tableView: GTableView, _ spec: Json, _ screen: GScreen) {
        self.tableView = tableView
        self.spec = spec
        self.screen = screen
    }

    open func createCell() -> GTableViewCell {
        fatalError("Need implementation")
    }

    public static func create(tableView: GTableView, spec: Json, screen: GScreen) -> JsonTemplate? {
        if let klass = JsonUi.loadClass(name: spec["template"].stringValue, type: JsonTemplate.self) as? JsonTemplate.Type {
            return klass.init(tableView, spec, screen)
        }
        GLog.w("Failed loading template: \(spec)")
        return nil
    }
}
