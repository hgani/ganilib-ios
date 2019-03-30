import UIKit

open class GNavigationController: UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Set transparency images so that the bar's transparency is determined only by one attribute, i.e. isTranslucent
        // This is important for setting edgesForExtendedLayout in GScreen
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }

    public func translucent(_ translucent: Bool) -> Self {
        navigationBar.isTranslucent = translucent
        return self
    }
}
