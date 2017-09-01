import SVProgressHUD

public protocol ProgressIndicator {
    func showProgress()
    func hideProgress()
    func showError(message: String)
}

public class StandardProgressIndicator: ProgressIndicator {
    static let shared = StandardProgressIndicator()
    
    public func showProgress() {
        SVProgressHUD.show()
    }
    
    public func hideProgress() {
        SVProgressHUD.dismiss()
    }
    
    public func showError(message: String) {
        SVProgressHUD.showError(withStatus: message)
    }
}

public class NullProgressIndicator: ProgressIndicator {
    public static let shared = NullProgressIndicator()
    
    public func showProgress() {
        // Do nothing
    }
    
    public func hideProgress() {
        // Do nothing
    }
    
    public func showError(message: String) {
        // Do nothing
    }
}

