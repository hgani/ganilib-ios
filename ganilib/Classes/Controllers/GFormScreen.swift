
import UIKit
import Eureka

open class GFormScreen : FormViewController {
    private var helper : ScreenHelper!
    private(set) var launch : LaunchHelper!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.helper = ScreenHelper(self)
        self.launch = LaunchHelper(self)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.viewWillAppear()
    }
    
    
    public func setupLeftMenuButton() {
        helper.setupLeftMenuButton();
    }
}

