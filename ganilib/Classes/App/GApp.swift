
import UIKit

public class GApp {
    private var navigationController: UINavigationController!
    public var window: UIWindow!
//
//    public init(_ navigationController : UINavigationController) {
//        //super.init(nibName: nil, bundle: nil)
//        //initialize()
//        self.navigationController = navigationController
//        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = navigationController
//    }
    
    static public let instance = GApp()
    
//    static public create() -> Self {
//    
//    }
    
    public func withNav(_ navigationController : UINavigationController) -> Self {
        //super.init(nibName: nil, bundle: nil)
        //initialize()
        self.navigationController = navigationController
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        return self
    }
    
//    public func initNavigation(_ navigationController : UINavigationController) -> UIWindow {
////        let portfolioScreen = screen
////        let navigationController = ApplicationController(rootViewController: portfolioScreen)
//        
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = navigationController
//        
//        return window
//    }
//    
    
    
    
    /*
    private func initialize() {
    }
    
     init() {
     super.init(nibName: nil, bundle: nil)
     initialize()
     }
     
     required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     initialize()
     }
     
     private func initialize() {
     }
     */
    
}
