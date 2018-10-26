import SideMenu
import SwiftIconFont
import UIKit

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
            .icon(from: .fontAwesome, code: "bars")
            .onClick({
                self.leftMenuButtonPressed()
            })

        screen.controller.navigationItem.leftBarButtonItem = navItem
    }

    public func leftMenu(controller: UIViewController) {
        setupLeftMenuButton()

        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: controller)
        menuLeftNavigationController.leftSide = true

        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: screen.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: screen.navigationController!.view)
        SideMenuManager.default.menuPresentMode = .viewSlideOut
        SideMenuManager.default.menuFadeStatusBar = false
    }

    @objc func leftMenuButtonPressed() {
        screen.controller.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

    // Made public so that it's accessible from GaniWeb
    public func viewWillAppear() {
        updateBadge()
    }

    @objc fileprivate func applicationDidBecomeActiveNotification(_: Notification) {
        updateBadge()
    }

    private func updateBadge() {
        // Can be nil since not all screens have nav menu.
        navItem?.setBadge(text: UIApplication.shared.applicationIconBadgeNumber > 0 ? "!" : "")
    }
}
