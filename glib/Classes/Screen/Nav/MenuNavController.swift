import SideMenu
import UIKit

open class MenuNavController: GScreen {
    fileprivate let tableView = GTableView().width(.matchParent)

    private let menu = Menu()

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Use our main nav controller instead of SideMenu's
        nav = NavHelper(navController: GApp.instance.navigationController)

        initMenu(menu)

        container.content.addView(
            tableView
                .autoRowHeight(estimate: 50)
                .delegate(self)
                .source(self)
                .reload()
        )
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMenu(menu)
        tableView.reloadData()
    }

//    open override func viewDidDisappear(_ animated: Bool) {
//        Log.t("CLEARING MENU")
//        menu.clear()
//        tableView.reloadData()
//    }

    open func initMenu(_: Menu) {
        fatalError("Must be overridden")
    }

    open func updateMenu(_: Menu) {
        // To be overridden
    }

//    @objc private func clearBadge() {
//        UIApplication.shared.applicationIconBadgeNumber = 0
//    }
}

extension MenuNavController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return menu.count
    }

    private func item(at indexPath: IndexPath) -> MenuItem {
        return menu[indexPath.row]
    }

    public func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(at: indexPath)
        let cell = tableView.cellInstance(of: item.cellClass, style: .default)

        (cell as? MenuCellType)?.update(item: item)

        return cell
    }

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menu[indexPath.row] as MenuItem

        dismiss(animated: true, completion: {
            if item.isRoot {
                _ = self.nav.backToHome()
            }

            if let controller = item.controller {
                self.nav.backToHome(animated: false).push(controller)
            }

            if let onClick = item.onClick {
                onClick()
            }

//            switch menu.type {
//            case .turbolinks:
//                let session = navigationController?.session
//                navigationController?.presentVisitableForSession(session!,
//                                                                 url: menu.url!,
//                                                                 action: .Replace)
//            case .notification:
//                let session = navigationController?.session
//                let controller = NotificationViewController(url: menu.url!)
//                navigationController?.presentVisitableForSession(session!,
//                                                                 controller: controller,
//                                                                 action: .Replace)
//            }

        })
    }

//    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menu.count
//    }
//
//    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = menu[indexPath.row] as MenuItem
//
//        let cell = tableView.cellInstance(of: MenuCell.self, style: .default)
//
    ////        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MenuCell.self), for: indexPath) as! MenuCell
//        cell.menu = menu[indexPath.row] as MenuItem
//        return cell
//    }
//
//    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    ////        let previousItem = MenuNavController.currentItem
//        let item = menu[indexPath.row] as MenuItem
    ////        MenuNavController.currentItem = item
//
//        dismiss(animated: true, completion: {
//            if item.isRoot {
//                _ = self.nav.backToHome()
//            }
//
//            if let controller = item.controller {
//                self.nav.backToHome(animated: false).push(controller)
//            }
//
//            if let onClick = item.onClick {
//                onClick()
//            }
//
    ////            switch menu.type {
    ////             .popToRoot:
    ////                _ = navigationController?.popToRootViewController(animated: true)
    ////            case .push:
    ////                _ = navigationController?.popToRootViewController(animated: false)
    ////                navigationController?.pushViewController(menu.controller!, animated: true)
    ////            case .turbolinks:
    ////                let session = navigationController?.session
    ////                navigationController?.presentVisitableForSession(session!,
    ////                                                                 url: menu.url!,
    ////                                                                 action: .Replace)
    ////            case .notification:
    ////                let session = navigationController?.session
    ////                let controller = NotificationViewController(url: menu.url!)
    ////                navigationController?.presentVisitableForSession(session!,
    ////                                                                 controller: controller,
    ////                                                                 action: .Replace)
    ////            case .method:
    ////                // Nothing to do. onClick() must have been executed regardless.
    //////                NSLog("Executing method ...")
    ////                //    self.perform(menu.method)
    ////            }
//
//        })
//    }
}
