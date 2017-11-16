
import UIKit
import MessageUI
import SVProgressHUD

open class IndicatorHelper {
    private unowned let screen: UIViewController
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    public init(_ screen: UIViewController) {
        self.screen = screen
    }
    
//    // TODO: Should be deprecated in favour of SVProgressHUD
//    public func showView() {
//        //[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
//        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        indicator.center = screen.view.center
//        indicator.backgroundColor = .white
//        //indicator.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
//        
//        indicator.layer.borderWidth = 1
//        indicator.layer.cornerRadius = 6
//        indicator.layer.borderColor = UIColor.lightGray.cgColor
//        
//        screen.view.addSubview(indicator)
//        indicator.bringSubview(toFront: screen.view)
//        
//        indicator.startAnimating()
//    }
//    
//    // TODO: Should be deprecated in favour of SVProgressHUD
//    public func hideView() {
//        indicator.stopAnimating()
//    }
    
    public func show() {
        SVProgressHUD.show()
    }
    
    public func hide() {
        SVProgressHUD.dismiss()
    }
    
    public func show(success: String) {
        SVProgressHUD.showSuccess(withStatus: success)
    }
    
    public func show(error: String) {
        SVProgressHUD.showError(withStatus: error)
    }
}
