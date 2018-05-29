
//public enum MenuType {
//    case popToRoot
//    case push
//    case turbolinks
//    case notification
//}

public class MenuItem {
    public private(set) var title: String
    public private(set) var icon: String?
    private(set) var controller: UIViewController?
    private(set) var onClick: (() -> Void)?
    
    private(set) var isRoot = false
    private(set) var cellClass: GTableViewCustomCell.Type = MenuCell.self
    
    public init(title: String, icon: String, root: Bool) {
        self.title = title
        self.icon = icon
        self.isRoot = root
    }
    
    public init(title: String) {
        self.title = title
    }
    
//    public init(title: String, icon: String, onClick: @escaping () -> Void) {
//        self.title = title
//        self.icon = icon
//        self.onClick = onClick
//    }
    
    public func icon(_ icon: String) -> Self {
        self.icon = icon
        return self
    }
    
    public func screen(_ screen: GScreen) -> Self {
        self.controller = screen
        return self
    }
    
    public func screen(_ screen: GFormScreen) -> Self {
        self.controller = screen
        return self
    }
    
    public func onClick(_ onClick: @escaping () -> Void) -> Self {
        self.onClick = onClick
        return self
    }
    
    public func cellClass(_ cellClass: GTableViewCustomCell.Type) -> Self {
        self.cellClass = cellClass
        return self
    }
    
    public func hasAction() -> Bool {
        return controller != nil || onClick != nil
    }
}
