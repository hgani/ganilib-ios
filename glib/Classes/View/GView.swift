import UIKit

public protocol IView {
    var size: CGSize { get }

    func color(bg: UIColor) -> Self

    func width(_ width: Int) -> Self
    func width(_ width: LayoutSize) -> Self

    func height(_ height: Int) -> Self
    func height(_ height: LayoutSize) -> Self

    func paddings(top: Float?, left: Float?, bottom: Float?, right: Float?) -> Self
}

open class GView: UIView {
    private var helper: ViewHelper!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder: NSCoder) {
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

    @discardableResult
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }

    @discardableResult
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }

    @discardableResult
    public func width(weight: Float) -> Self {
        helper.width(weight: weight)
        return self
    }

    @discardableResult
    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    @discardableResult
    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }

    @discardableResult
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        return self
    }

    @discardableResult
    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }
}
