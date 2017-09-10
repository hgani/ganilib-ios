
import UIKit
import MessageUI

open class NavHelper {
    // NOTE: Not sure if we need to set this to weak. We tried unowned but got "bad access".
    private var screen: ScreenProtocol?
    private let navController: UINavigationController!
    private var showBar = true
    
    // TODO: Consider removing this now that we've got a generic solution for popAndRefresh()
    private var previous: ScreenProtocol?
    
    convenience public init(_ screen : ScreenProtocol) {
        self.init(navController: screen.navigationController!)
        self.screen = screen
    }
    
    init(navController : UINavigationController) {
        self.navController = navController
    }
    
    public func hideBar() {
        self.showBar = false
    }
    
    public func title(_ title: String) -> Self {
        screen?.title = title
        return self
    }
    
    public func color(bg: UIColor, text: UIColor) {
        navController.navigationBar.barTintColor = bg
        navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: text]
        navController.navigationBar.tintColor = text  // For built-in back button
    }
    
    public func viewWillAppear() {
        navController.setNavigationBarHidden(!showBar, animated: false)
    }
    
    public func backToHome(animated : Bool = true) -> Self {
        navController.popToRootViewController(animated: animated)
        return self
    }
    
    public func refresh() {
        if let screen = navController.topViewController as? ScreenProtocol {
            screen.onRefresh()
        }
    }
    
    public func push(_ controller : UIViewController, animated : Bool = true) {
//        if var next = controller as? ScreenProtocol {
//            next.previous = self.screen
//        }

        navController.pushViewController(controller, animated: animated)
    }
    
    public func popAndPush(_ controller : UIViewController, animated : Bool = true) {
//        // See http://stackoverflow.com/questions/6872852/popping-and-pushing-view-controllers-in-same-action
        var vcArray = navController.viewControllers
        vcArray.removeLast()
        vcArray.append(controller)
        navController.setViewControllers(vcArray, animated: animated)
    }
    
    public func pop(animated : Bool = true) -> Self {
        navController.popViewController(animated: animated)
        return self
    }
    
//    public func popAndRefresh(animated : Bool = true) {
//        if let p = screen?.previous {
//            p.onRefresh()
//        }
//        pop(animated: animated)
//    }
}
