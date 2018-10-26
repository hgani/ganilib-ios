import MessageUI
import UIKit

open class NavHelper {
    private let navController: UINavigationController!
    private var showBar = true

    public convenience init(_ screen: ScreenProtocol) {
        self.init(navController: screen.navigationController!)
    }

    init(navController: UINavigationController) {
        self.navController = navController
    }

    public func hideBar() {
        showBar = false
    }

    public func color(bg: UIColor, text: UIColor) {
        navController.navigationBar.barTintColor = bg
        navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: text]
        navController.navigationBar.tintColor = text // For built-in back button
    }

    public func viewWillAppear() {
        navController.setNavigationBarHidden(!showBar, animated: false)
    }

    public func backToHome(animated: Bool = true) -> Self {
        navController.popToRootViewController(animated: animated)
        return self
    }

    public func refresh() {
        if let screen = navController.topViewController as? ScreenProtocol {
            screen.onRefresh()
        }
    }

    public func push(_ controller: UIViewController, animated: Bool = true) {
        navController.pushViewController(controller, animated: animated)
    }

    public func popAndPush(_ controller: UIViewController, animated: Bool = true) {
        // See http://stackoverflow.com/questions/6872852/popping-and-pushing-view-controllers-in-same-action
        var vcArray = navController.viewControllers
        vcArray.removeLast()
        vcArray.append(controller)
        navController.setViewControllers(vcArray, animated: animated)
    }

    public func pop(animated: Bool = true) -> Self {
        navController.popViewController(animated: animated)
        return self
    }

    public func done() {
        // End chaining
    }
}
