
import UIKit
import SwiftIconFont
import SideMenu

open class ScreenHelper {
    private unowned let screen: ScreenProtocol
    
    private var navItem: UIBarButtonItem?
    
    public init(_ screen: ScreenProtocol) {
        self.screen = screen
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActiveNotification(_:)),
                                               name: .UIApplicationWillEnterForeground,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupLeftMenuButton() {
        // Use customView to ensure UIBarButtonItem.view exists at all times or else the badge won't appear as we navigate
        // to other screens. See http://stackoverflow.com/questions/43641698/getting-frame-of-uibarbuttonitem-returns-nil
        navItem = GBarButtonItem()
            .icon(from: .FontAwesome, code: "bars")
            .onClick({
                self.leftMenuButtonPressed()
        })
        
        screen.controller.navigationItem.leftBarButtonItem = navItem
    }
    
    public func leftMenu(controller: UITableViewController) {
        setupLeftMenuButton()
        
//        let menuNavigationController = MenuNavigationController()
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: controller)
        menuLeftNavigationController.leftSide = true
        
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: screen.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: screen.navigationController!.view)
        SideMenuManager.menuPresentMode = .viewSlideOut
        SideMenuManager.menuFadeStatusBar = false
    }
    
//    public func rightBarButton(item: GBarButtonItem) {
//        screen.navigationItem.rightBarButtonItem = item
//        
////        setupLeftMenuButton()
////        
////        //        let menuNavigationController = MenuNavigationController()
////        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: controller)
////        menuLeftNavigationController.leftSide = true
////        
////        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
////        SideMenuManager.menuAddPanGestureToPresent(toView: screen.navigationController!.navigationBar)
////        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: screen.navigationController!.view)
////        SideMenuManager.menuPresentMode = .viewSlideOut
////        SideMenuManager.menuFadeStatusBar = false
//    }
    
//    public func setupRightMenuButton(icon: Ionicons, target: UIViewController, action: Selector) {
//        let icon = UIImage.ionicon(with: icon, textColor: UIColor.white, size: CGSize(width: 24, height: 24))
//        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 0.0, y: 0.0, width: icon.size.width, height: icon.size.height)
//        button.setBackgroundImage(icon, for: UIControlState())
//        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
//        navItem = UIBarButtonItem(customView: button)
//
//        screen.navigationItem.rightBarButtonItem = navItem
//    }
    
    @objc func leftMenuButtonPressed() {
        screen.controller.present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
//    func populate() {
//        DispatchQueue.main.async {  // Make sure that the subclass' viewDidLoad() has finished executing
//            self.screen.onRefresh()
//        }
//    }
    
    // Made public so that it's accessible from GaniWeb
    public func viewWillAppear() {
        updateBadge();
    }
    
    @objc fileprivate func applicationDidBecomeActiveNotification(_ notification: Notification) {
        updateBadge()
    }
    
    private func updateBadge() {
        // Can be nil since not all screens have nav menu.
        self.navItem?.setBadge(text: UIApplication.shared.applicationIconBadgeNumber > 0 ? "!" : "")
    }
}
