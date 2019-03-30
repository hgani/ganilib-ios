import MessageUI
import SVProgressHUD
import UIKit

open class IndicatorHelper {
    private unowned let screen: UIViewController
    lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    public init(_ screen: UIViewController) {
        self.screen = screen
    }

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

    public func show(alert: String) {
        SVProgressHUD.dismiss()

        let alert = UIAlertController(title: nil, message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        screen.present(alert, animated: true, completion: nil)
    }
}
