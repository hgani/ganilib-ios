
import UIKit

public class GApp {
    private var navigationController: UINavigationController!
    public var window: UIWindow!

    static public let instance = GApp()
    
    public func withNav(_ navigationController : UINavigationController) -> Self {
        self.navigationController = navigationController
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        
//        window.backgroundColor = .white
//        window.makeKeyAndVisible()
        
        return self
    }
}
