import UIKit

open class GStackView: UIStackView {
    private var helper: ViewHelper!

    public var size: CGSize {
        return helper.size
    }

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

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
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

    public func withViews(_ views: UIView...) -> Self {
        for view in views {
            addArrangedSubview(view)
        }
        return self
    }

    public func axis(_ axis: UILayoutConstraintAxis) -> Self {
        self.axis = axis
        return self
    }

    public func spacing(_ spacing: Float) -> Self {
        self.spacing = CGFloat(spacing)
        return self
    }

    public func distribution(_ distribution: UIStackViewDistribution) -> Self {
        self.distribution = distribution
        return self
    }
}
