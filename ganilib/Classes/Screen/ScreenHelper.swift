
import UIKit
import SwiftIconFont
import IoniconsKit
import SideMenu
import SnapKit
import IoniconsKit

open class ScreenHelper {
    // NOTE: Not sure if we need to set this to weak. We tried unowned but got "bad access".
    private let screen : UIViewController
    
    private var navItem : UIBarButtonItem?
    
    public init(_ screen : UIViewController) {
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
        let icon = UIImage.ionicon(with: .navicon, textColor: UIColor.white, size: CGSize(width: 24, height: 24))
        //let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(leftMenuButtonPressed))
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: icon.size.width, height: icon.size.height)
        button.setBackgroundImage(icon, for: UIControlState())
        button.addTarget(self,
                         action: #selector(leftMenuButtonPressed),
                         for: UIControlEvents.touchUpInside)
        
        // Use customView to ensure UIBarButtonItem.view exists at all times or else the badge won't appear as we navigate
        // to other screens. See http://stackoverflow.com/questions/43641698/getting-frame-of-uibarbuttonitem-returns-nil
        navItem = UIBarButtonItem(customView: button)
        
        screen.navigationItem.leftBarButtonItem = navItem
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
    
    public func setupRightMenuButton(icon: Ionicons, target: UIViewController, action: Selector) {
        let icon = UIImage.ionicon(with: icon, textColor: UIColor.white, size: CGSize(width: 24, height: 24))
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: icon.size.width, height: icon.size.height)
        button.setBackgroundImage(icon, for: UIControlState())
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        navItem = UIBarButtonItem(customView: button)

        screen.navigationItem.rightBarButtonItem = navItem
    }
    
    @objc func leftMenuButtonPressed() {
        screen.present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
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
