import UIKit
import SideMenu
import IoniconsKit
//import SVProgressHUD

open class MenuNavController: UITableViewController {
//    private var menu = [MenuItem]()
    private let menu = Menu()
    private var notificationItem : MenuItem!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
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
//        let menu = menus[indexPath.row] as Menu
//        dismiss(animated: true, completion: {
//            let navigationController = AppDelegate.get().navigationController
//            
//            // TODO: better use this for check auth before navigate to screen
//            // or override viewWillAppear, but Turbolinks.VisitableViewController cant be override
//            if menu.requireAuth && AppDelegate.get().currentUser == nil {
//                let signinController = SigninController()
//                navigationController?.pushViewController(signinController, animated: true)
//                return
//            }
//            
//            if (menu.onClick != nil) {
//                self.perform(menu.onClick)
//            }
//            
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
//                NSLog("Executing method ...")
//                //    self.perform(menu.method)
//            }
//            
//        })
    }
}
