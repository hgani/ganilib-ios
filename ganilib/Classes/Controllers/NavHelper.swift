
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
    
    public func viewWillAppear() {
        screen.navigationController?.setNavigationBarHidden(!showBar, animated: false)
    }
    
    public func backToHome() {
        screen.navigationController?.popToRootViewController(animated: true)
    }
}
