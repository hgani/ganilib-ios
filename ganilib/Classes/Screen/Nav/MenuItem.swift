
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
        isRoot = root
    }

    public init(title: String) {
        self.title = title
    }

    public func icon(_ icon: String) -> Self {
        self.icon = icon
        return self
    }

    public func screen(_ screen: GScreen) -> Self {
        controller = screen
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

#if INCLUDE_EUREKA

    extension MenuItem {
        public func screen(_ screen: GFormScreen) -> Self {
            controller = screen
            return self
        }
    }

#endif
