public class JsonUi {
    private static var moduleName: String?

    static func register(_ buildConfig: BuildConfig) {
        moduleName = moduleName(from: type(of: buildConfig) as! AnyClass)
    }

    private static func moduleName(from type: AnyClass) -> String {
        let object = NSStringFromClass(type) as NSString
        return object.components(separatedBy: ".").first!
    }

    private static func replaceNamespace(of str: String, with namespace: String) -> String {
        let libModule = moduleName(from: self)
        return str.replace(regex: "^\(libModule).", with: "\(namespace).")
    }

    static func loadClass(name: String, type: AnyClass) -> Swift.AnyClass? {
        let typeName = NSStringFromClass(type)
        let className = name
            .components(separatedBy: "/")
            // Don't use .capitalized() because that converts "showAlert" to "Showalert"
            .map { $0.prefix(1).uppercased() + $0.dropFirst() }
            .joined(separator: "_")
            .replacingOccurrences(of: "-v", with: "V")
        let nameWithLibPrefix = "\(typeName)_\(className)"
        GLog.d("Loading \(nameWithLibPrefix) from \(name) ...")
        if let clazz = NSClassFromString(nameWithLibPrefix) {
            return clazz
        }

        if let replacement = moduleName {
            let nameWithAppPrefix = replaceNamespace(of: nameWithLibPrefix, with: replacement)
            GLog.d("Loading \(nameWithAppPrefix) from \(name) ...")
            return NSClassFromString(nameWithAppPrefix)
        }

        return nil
    }

    public static func parseResponse(_ spec: Json, screen: UIViewController) {
        JsonAction.execute(spec: spec["onResponse"], screen: screen, creator: nil)
    }

    public static func parseScreen(_ spec: Json, screen: GScreen) {
        initVerticalPanel(screen.container.header, spec: spec["header"], screen: screen)
        initVerticalPanel(screen.container.content, spec: spec["content"], screen: screen)
        initVerticalPanel(screen.container.footer, spec: spec["footer"], screen: screen)
        JsonAction.execute(spec: spec["onLoad"], screen: screen, creator: nil)
    }

    private static func initVerticalPanel(_ panel: GVerticalPanel, spec: Json, screen: GScreen) {
        _ = JsonView_Panels_VerticalV1(panel, spec, screen).createView()
    }
}
