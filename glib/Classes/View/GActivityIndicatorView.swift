import UIKit

open class GActivityIndicatorView: UIActivityIndicatorView {
    private var helper: ViewHelper!

    public init() {
        super.init(frame: .zero)
        initialize()
    }

    public required init(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)
    }

    // Needed for helper.width() and helper.height()
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }

    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }

    public func width(weight: Float) -> Self {
        helper.width(weight: weight)
        return self
    }

    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }

    public func color(bg: UIColor?, fg: UIColor? = nil) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        if let fgColor = fg {
            color = fgColor
        }
        return self
    }

    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }
}
