import SVProgressHUD
import UIKit

open class GRefreshControl: UIRefreshControl, ProgressIndicator {
    private var helper: ViewHelper!
    private var onValueChanged: (() -> Void)?

    public override init() {
        super.init(frame: .zero)

        helper = ViewHelper(self)

        addTarget(self, action: #selector(performValueChanged), for: .valueChanged)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    public func onValueChanged(_ command: @escaping () -> Void) -> Self {
        onValueChanged = command
        return self
    }

    @objc private func performValueChanged() {
        if let callback = self.onValueChanged {
            callback()
        }
    }

    public func show() {
        beginRefreshing()

        // The following is for TableView and WebView so make sure to test both after modifying it.
        DispatchQueue.main.async {
            if let view = self.superview as? UIScrollView {
                // See https://stackoverflow.com/questions/14718850/uirefreshcontrol-beginrefreshing-not-working-when-uitableviewcontroller-is-ins
                view.setContentOffset(CGPoint(x: 0, y: view.contentOffset.y - self.frame.size.height), animated: true)
            }
        }
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

    public func show(progress _: Float) {
        // Not applicable yet
    }

    public func done() {
        // End chaining
    }
}
