
import UIKit
import Eureka

open class GFormScreen : FormViewController, ScreenProtocol {
    private var helper : ScreenHelper!
    public var launch : LaunchHelper!
    public var indicator : IndicatorHelper!
    public var nav : NavHelper!
    public var previous: ScreenProtocol?
    
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
    
//    
//    public func setupLeftMenuButton() {
//        helper.setupLeftMenuButton();
//    }
    
    public func headerForm(title: String?, height: CGFloat) -> HeaderFooterView<UIView> {
        var header = HeaderFooterView<UIView>(.class)
        header.height = {height}
        header.onSetupView = { view, section in
            view.backgroundColor = .white
            
            let label = UILabel()
            label.text = title
            label.numberOfLines = 0
            label.textAlignment = .center
            
            view.addSubview(label)
            
            label.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(view).offset(-20)
                make.height.equalTo(view)
                make.left.equalTo(10)
                make.right.equalTo(10)
            }
        }
        
        return header
    }
    
    public func leftMenu(controller: UITableViewController) -> Self {
        helper.leftMenu(controller: controller)
        return self
    }
    
    public func end() {
        // Ends chaining
    }
    
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
//        _ = self.contentView.padding(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    open func onRefresh() {
        // To be overridden
    }
}

