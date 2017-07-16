
import UIKit
import MessageUI

open class NavHelper {
    // NOTE: Not sure if we need to set this to weak. We tried unowned but got "bad access".
    private let screen : UIViewController
    private var showBar = true
    
    public init(_ screen : UIViewController) {
        self.screen = screen
    }
    
    public func hideBar() {
        self.showBar = false
    }
    
    public func title(_ title: String) -> Self {
        screen.title = title
        return self
    }
    
    public func color(bg: UIColor, text: UIColor) {
        if let navController = screen.navigationController {
            navController.navigationBar.barTintColor = bg
            navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: text]
            //        UINavigationBar.appearance().tintColor = UIColor.red
        }
    }
    
    public func viewWillAppear() {
        screen.navigationController?.setNavigationBarHidden(!showBar, animated: false)
    }
    
    public func backToHome() {
        screen.navigationController?.popToRootViewController(animated: true)
    }
}
