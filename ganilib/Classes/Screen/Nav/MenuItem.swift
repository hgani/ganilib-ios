
public enum MenuType {
    case popToRoot
    case push
    case turbolinks
    case notification
    case method
}

public class MenuItem {
    private(set) var title: String
    private(set) var icon: String
    private(set) var controller: UIViewController?
    var url: URL?
    //var method: Selector?
    var requireAuth: Bool = false
    var type: MenuType
    private(set) var onClick: (() -> Void)?
    private(set) var isRoot = false
    
    public init(title: String, icon: String) {
        self.title = title
        self.icon = icon
        self.type = MenuType.popToRoot
        self.isRoot = true
    }
    
    public init(title: String, icon: String, controller: UIViewController) {
        self.title = title
        self.icon = icon
        self.controller = controller
        self.type = MenuType.push
    }
    
//    public init(title: String, icon: String, url: URL, requireAuth: Bool = false, onClick: Selector? = nil, type: MenuType = .turbolinks) {
//        self.title = title
//        self.icon = icon
//        self.url = url
//        self.requireAuth = requireAuth
//        self.type = type
//        self.onClick = onClick
//    }
//    
//    public init(title: String, icon: String, onClick: Selector) {
//        self.title = title
//        self.icon = icon
//        self.onClick = onClick
//        self.type = MenuType.method
//    }
    
    public init(title: String, icon: String, onClick: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.onClick = onClick
        self.type = MenuType.method
    }
}
