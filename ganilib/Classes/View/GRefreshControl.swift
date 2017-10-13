
import UIKit
import SVProgressHUD

open class GRefreshControl: UIRefreshControl, ProgressIndicator {
    private var helper : ViewHelper!
    private var onValueChanged : (() -> Void)?
    
    override public init() {
        super.init(frame: .zero)
        
        self.helper = ViewHelper(self)
        
        addTarget(self, action: #selector(performValueChanged), for: UIControlEvents.valueChanged)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    public func onValueChanged(_ command: @escaping () -> Void) -> Self {
        self.onValueChanged = command
        return self
    }
    
    @objc private func performValueChanged() {
        if let callback = self.onValueChanged {
            callback()
        }
    }
    
    public func show() {
        if let tableView = superview as? UITableView {
            // See https://stackoverflow.com/questions/14718850/uirefreshcontrol-beginrefreshing-not-working-when-uitableviewcontroller-is-ins
            tableView.setContentOffset(CGPoint(x: 0,y: tableView.contentOffset.y - self.frame.size.height), animated: true)
        }
        beginRefreshing()
    }
    
    public func hide() {
        endRefreshing()
    }
    
    public func show(error: String) {
        SVProgressHUD.showError(withStatus: error)
    }
    
    public func show(success: String) {
        SVProgressHUD.showSuccess(withStatus: success)
    }
    
    public func end() {
        // End chaining initialisation
    }
}
