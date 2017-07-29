
import UIKit
import Eureka

open class GFormScreen : FormViewController {
    private var helper : ScreenHelper!
    public var launch : LaunchHelper!
    public var nav : NavHelper!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.helper = ScreenHelper(self)
        self.launch = LaunchHelper(self)
        self.nav = NavHelper(self)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        helper.viewWillAppear()
    }
    
    
    public func setupLeftMenuButton() {
        helper.setupLeftMenuButton();
    }
    
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
}

