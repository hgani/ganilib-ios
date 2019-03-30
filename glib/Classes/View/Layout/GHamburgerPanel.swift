import UIKit

open class GHamburgerPanel: UIView, IContainer {
    private var helper: ViewHelper!

    public var size: CGSize {
        return helper.size
    }

    public init() {
        super.init(frame: .zero)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)

        _ = paddings(top: 0, left: 0, bottom: 0, right: 0)
    }

    public func withViews(_ top: UIView, _ middle: UIView, _ bottom: UIView, includeNotch: Bool) -> Self {
        // The hope is this makes things more predictable
        top.translatesAutoresizingMaskIntoConstraints = false
        middle.translatesAutoresizingMaskIntoConstraints = false
        bottom.translatesAutoresizingMaskIntoConstraints = false

        addSubview(top)
        addSubview(middle)
        addSubview(bottom)

        top.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)
            make.top.equalTo(self.snp.topMargin)
        }

        middle.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)

            make.top.equalTo(top.snp.bottom)
            make.bottom.equalTo(bottom.snp.top)
        }
        bottom.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)

            if includeNotch {
                make.bottom.equalTo(self.snp.bottom)
            } else {
                make.bottom.equalTo(self.snp.bottomMargin)
            }
        }

        snp.makeConstraints { make in
            make.rightMargin.greaterThanOrEqualTo(top.snp.right)
            make.rightMargin.greaterThanOrEqualTo(middle.snp.right)
            make.rightMargin.greaterThanOrEqualTo(bottom.snp.right)
        }
        return self
    }

    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

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

    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }

    public func paddings(top: Float? = nil, left: Float? = nil, bottom: Float? = nil, right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

    @discardableResult
    public func bg(image: UIImage?, repeatTexture: Bool) -> Self {
        helper.bg(image: image, repeatTexture: repeatTexture)
        return self
    }
}
