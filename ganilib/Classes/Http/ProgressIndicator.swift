import SVProgressHUD

public protocol ProgressIndicator {
    func show()
    func hide()
    func show(error: String)
    func show(success: String)
}

public class StandardProgressIndicator: ProgressIndicator {
    public static let shared = StandardProgressIndicator()
    
    public func show() {
        SVProgressHUD.show()
    }
    
    public func hide() {
        SVProgressHUD.dismiss()
    }
    
    public func show(error: String) {
        SVProgressHUD.showError(withStatus: error)
    }
    
    public func show(success: String) {
        SVProgressHUD.showSuccess(withStatus: success)
    }
}

public class NullProgressIndicator: ProgressIndicator {
    public static let shared = NullProgressIndicator()
    
    public func show() {
        // Do nothing
    }
    
    public func hide() {
        // Do nothing
    }
    
    public func show(error: String) {
        // Do nothing
    }
    
    public func show(success: String) {
        // Do nothing
    }
}

