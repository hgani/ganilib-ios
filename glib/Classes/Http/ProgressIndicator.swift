import SVProgressHUD

public protocol ProgressIndicator {
    func show()
    func hide()
    func show(error: String)
    func show(success: String)
    func show(progress: Float)
}

public class ProgressIndicatorEnum {
    public static let null = ProgressIndicatorEnum(NullProgressIndicator.shared)
    public static let standard = ProgressIndicatorEnum(StandardProgressIndicator.shared)

    public let backend: ProgressIndicator

    init(_ backend: ProgressIndicator) {
        self.backend = backend
    }
}

private class StandardProgressIndicator: ProgressIndicator {
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

    public func show(progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
}

private class NullProgressIndicator: ProgressIndicator {
    public static let shared = NullProgressIndicator()

    public func show() {
        // Do nothing
    }

    public func hide() {
        // Do nothing
    }

    public func show(error _: String) {
        // Do nothing
    }

    public func show(success _: String) {
        // Do nothing
    }

    public func show(progress _: Float) {
        // Do nothing
    }
}
