import UIKit

open class GNavigationController: UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Set transparency images so that the bar's transparency is determined only by one attribute, i.e. isTranslucent
        // This is important for setting edgesForExtendedLayout in GScreen
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
    }
    
    public func translucent(_ translucent: Bool) -> Self {
        self.navigationBar.isTranslucent = translucent
        return self
    }
}
