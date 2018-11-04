import UIKit

open class GSplitPanel: UIView, IView {
    private var helper: ViewHelper!
    private var event: EventHelper<GSplitPanel>!

    public var size: CGSize {
        return helper!.size
    }

    public init() {
        super.init(frame: .zero)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)
        event = EventHelper(self)

        _ = paddings(top: 0, left: 0, bottom: 0, right: 0)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    private func decreaseResistance(view: UIView) {
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        for subview in view.subviews {
            decreaseResistance(view: subview)
        }
    }

    public func withViews(left: UIView, right: UIView) -> Self {
        // The hope is this makes things more predictable
        left.translatesAutoresizingMaskIntoConstraints = false
        right.translatesAutoresizingMaskIntoConstraints = false

        addSubview(left)
        addSubview(right)

        initConstraints(left: left, center: nil, right: right)

        return self
    }

    public func withViews(_ left: UIView, _ center: UIView, _ right: UIView) -> Self {
        // The hope is this makes things more predictable
        left.translatesAutoresizingMaskIntoConstraints = false
        center.translatesAutoresizingMaskIntoConstraints = false
        right.translatesAutoresizingMaskIntoConstraints = false

        // Avoid squashing the right view
        decreaseResistance(view: center)

        addSubview(left)
        addSubview(center)
        addSubview(right)

        initConstraints(left: left, center: center, right: right)

        return self
    }

    private func initConstraints(left: UIView, center: UIView?, right: UIView) {
        left.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.left.equalTo(self.snp.leftMargin)

            //            make.right.greaterThanOrEqualTo(right.snp.left)
            //            make.right.lessThanOrEqualTo(right.snp.left)
        }
        center?.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)

            make.left.equalTo(left.snp.right)
            make.right.equalTo(right.snp.left)
            //            make.width.equalTo(self)
        }
        right.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.right.equalTo(self.snp.rightMargin)
        }

        snp.makeConstraints { make in
            //            make.bottomMargin.equalTo(left.snp.bottom)
            //            make.bottomMargin.equalTo(center.snp.bottom)
            //            make.bottomMargin.equalTo(right.snp.bottom)

            make.bottomMargin.greaterThanOrEqualTo(left.snp.bottom)
            if let centerView = center {
                make.bottomMargin.greaterThanOrEqualTo(centerView.snp.bottom)
            }
            make.bottomMargin.greaterThanOrEqualTo(right.snp.bottom)
        }
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

    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

    public func onClick(_ command: @escaping (GSplitPanel) -> Void) -> Self {
        event.onClick(command)
        return self
    }

    public func interaction(_ enabled: Bool) -> Self {
        isUserInteractionEnabled = enabled
        return self
    }
}
