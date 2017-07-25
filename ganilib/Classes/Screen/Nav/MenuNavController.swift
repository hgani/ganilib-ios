import UIKit
import SideMenu
import IoniconsKit
//import SVProgressHUD

open class MenuNavController: UITableViewController {
//    static private var currentItem: MenuItem?
    
    private let menu = Menu()
    private var notificationItem : MenuItem!
    public var nav : NavHelper!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nav = NavHelper(navController: GApp.instance.navigationController)
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        initMenu(menu)
        tableView.register(MenuCell.self, forCellReuseIdentifier: NSStringFromClass(MenuCell.self))
        tableView.tableFooterView = UIView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        menus.removeLast(1)
//        
//        let notificationPrefix = (UIApplication.shared.applicationIconBadgeNumber > 0) ? " *" : ""
//        notificationItem.title = "Notifications\(notificationPrefix)"
        
        Log.i("RELOADING DATA")
        
        menu.clear()
        initMenu(menu)
        tableView.reloadData()
    }
    
    open func initMenu(_ menu: Menu) {
//        let navigationController = AppDelegate.get().navigationController
//        
//        menus.append(Menu.init(title: "Home", icon: "io:ios-home"))
        
        Log.i("To be overridden")
    }
    
    
    @objc private func clearBadge() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MenuCell.self), for: indexPath) as! MenuCell
        cell.menu = menu[indexPath.row] as MenuItem
        return cell
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let previousItem = MenuNavController.currentItem
        let item = menu[indexPath.row] as MenuItem
//        MenuNavController.currentItem = item
        
        dismiss(animated: true, completion: {
//            Log.i("ITEM: \(previousItem) === \(item)")
//            if item === previousItem {
//                return
//            }
            
//            let navigationController = AppDelegate.get().navigationController
//            
//            // TODO: better use this for checking auth before navigate to screen
//            // or override viewWillAppear, but Turbolinks.VisitableViewController cant be overriden
//            if menu.requireAuth && AppDelegate.get().currentUser == nil {
//                let signinController = SigninController()
//                navigationController?.pushViewController(signinController, animated: true)
//                return
//            }
            
            if item.isRoot {
                self.nav.backToHome()
            }
            
            if let controller = item.controller {
                self.nav.backToHome(animated: false).push(controller)
            }
            
            if let onClick = item.onClick {
                onClick()
            }
            
//            switch menu.type {
//            case .popToRoot:
//                _ = navigationController?.popToRootViewController(animated: true)
//            case .push:
//                _ = navigationController?.popToRootViewController(animated: false)
//                navigationController?.pushViewController(menu.controller!, animated: true)
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
//            case .method:
//                // Nothing to do. onClick() must have been executed regardless.
////                NSLog("Executing method ...")
//                //    self.perform(menu.method)
//            }
            
        })
    }
}
