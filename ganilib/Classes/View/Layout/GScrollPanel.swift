
import UIKit

open class GScrollPanel: UIScrollView, IContainer {
    private var helper: ViewHelper!
    private let contentView = GVerticalPanel()

    public var size: CGSize {
        return helper.size
    }

    public init() {
        super.init(frame: .zero)

        helper = ViewHelper(self)

        // See https://github.com/zaxonus/AutoLayScroll
//        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(self)

            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }

    public required init?(coder _: NSCoder) {
        fatalError("Not supported")
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

    public func clearViews() {
        contentView.clearViews()
    }

    public func addView(_ view: UIView, top: CGFloat? = nil) {
        contentView.addView(view, top: top)
    }

    public func append(_ view: UIView, top: CGFloat? = nil) -> Self {
        _ = contentView.append(view, top: top)
        return self
    }

    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        _ = contentView.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

    // UIScrollView delays touch event handling by default.
    public func delayTouch(_ delay: Bool) -> Self {
        delaysContentTouches = delay
        return self
    }

    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

    public func done() {
        // End chaining
    }

//    public func test() {
//        contentView.height(300)
//    }
}
