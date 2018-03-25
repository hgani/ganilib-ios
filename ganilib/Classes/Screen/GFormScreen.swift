
import UIKit
import Eureka

open class GFormScreen: FormViewController {
    private var helper : ScreenHelper!
    public var launch : LaunchHelper!
    public var indicator : IndicatorHelper!
    public var nav : NavHelper!
    public var previous: ScreenProtocol?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.helper = ScreenHelper(self)
        self.launch = LaunchHelper(self)
        self.indicator = IndicatorHelper(self)
        self.nav = NavHelper(self)        
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.viewWillAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // See https://stackoverflow.com/questions/8228411/detecting-when-the-back-button-is-pressed-on-a-navbar
        if self.isMovingFromParentViewController || self.isBeingDismissed {
            onPopping()
        }
    }
    
    open func onPopping() {
        // To be overridden
    }
    
    public func rightBarButton(item: UIBarButtonItem) -> Self {
        self.navigationItem.rightBarButtonItem = item
        return self
    }
    
//    public func headerForm(title: String?, height: CGFloat) -> HeaderFooterView<UIView> {
//        var header = HeaderFooterView<UIView>(.class)
//        header.height = {height}
//        header.onSetupView = { view, section in
//            view.backgroundColor = .white
//
//            let label = UILabel()
//            label.text = title
//            label.numberOfLines = 0
//            label.textAlignment = .center
//
//            view.addSubview(label)
//
//            label.snp.makeConstraints { (make) -> Void in
//                make.width.equalTo(view).offset(-20)
//                make.height.equalTo(view)
//                make.left.equalTo(10)
//                make.right.equalTo(10)
//            }
//        }
//
//        return header
//    }
    
    public func leftMenu(controller: GScreen) -> Self {
        helper.leftMenu(controller: controller)
        return self
    }
    
    public func leftBarButton(item: UIBarButtonItem) -> Self {
        self.navigationItem.leftBarButtonItem = item
        return self
    }
    
    public func end() {
        // Ends chaining
    }
    
    // Don't declare this in an extension or else we'll get compile error
    // See https://stackoverflow.com/questions/44616409/declarations-in-extensions-cannot-override-yet-error-in-swift-4
    open func onRefresh() {
        // To be overridden
    }
}

extension GFormScreen: ScreenProtocol {
    public var controller: UIViewController {
        get {
            return self
        }
    }
}

