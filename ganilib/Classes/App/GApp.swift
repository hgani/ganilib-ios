
import UIKit

public class GApp {
    private static let info = (Bundle.main.infoDictionary ?? [:])
    public static let version = (info["CFBundleShortVersionString"] as? String) ?? "Unknown"
    
    public var navigationController: GNavigationController!
    public var window: UIWindow!

    static public let instance = GApp()
    
    public func withNav(_ navigationController: GNavigationController) -> Self {
        self.navigationController = navigationController
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        
//        window.backgroundColor = .white
//        window.makeKeyAndVisible()
        
        return self
    }
}
