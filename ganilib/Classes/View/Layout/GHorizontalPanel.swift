import SnapKit
import UIKit

open class GHorizontalPanel: UIView {
    fileprivate var helper: ViewHelper!
//    private var previousViewElement: UIView!
//    private var previousConstraint: NSLayoutConstraint!

    private var previousView: UIView?
    private var previousLayoutPriority: UILayoutPriority?
    private var rightConstraint: Constraint?

    private var totalGap = Float(0.0)

    private var paddings: Paddings {
        return helper.paddings
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

        _ = paddings(top: 0, left: 0, bottom: 0, right: 0)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func clearViews() {
        previousView = nil
        rightConstraint = nil

        for view in subviews {
            view.removeFromSuperview()
        }
    }

    public func addView(_ child: UIView, left: Float = 0) {
        totalGap += left

        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false

        super.addSubview(child)
        initChildConstraints(child: child, left: left)
        adjustParentBottomConstraint(child: child)

        previousView = child
    }

    @discardableResult
    public func append(_ child: UIView, left: Float = 0) -> Self {
        addView(child, left: left)
        return self
    }

    // See https://github.com/zaxonus/AutoLayScroll/blob/master/AutoLayScroll/ViewController.swift
    private func initChildConstraints(child: UIView, left: Float) {
        child.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)

            if let view = previousView {
                make.left.equalTo(view.snp.right).offset(left)
            } else {
                make.left.equalTo(self.snp.leftMargin).offset(left)
            }
        }
    }

    private func adjustParentBottomConstraint(child: UIView) {
        snp.makeConstraints { make in
            // Don't use greaterThanOrEqualTo() or else this view will get stretched in HamburgerPanel.
//            make.bottomMargin.equalTo(child.snp.bottom)

            make.bottomMargin.greaterThanOrEqualTo(child.snp.bottom)
        }

        if helper.shouldWidthMatchParent() {
            rightConstraint?.deactivate()

            child.snp.makeConstraints { make in
                rightConstraint = make.right.lessThanOrEqualTo(self.snp.rightMargin).constraint
            }

            // Decrease resistance of the last view to avoid squashing the previous views which
            // would happen if the last view is longer than the available space.
            if let view = previousView, let priority = previousLayoutPriority {
                ViewHelper.setResistance(view: view, axis: .horizontal, priority: priority)
            }
            previousLayoutPriority = ViewHelper.decreaseResistance(view: child, axis: .horizontal)

        } else {
            rightConstraint?.deactivate()

            child.snp.makeConstraints { make in
                rightConstraint = make.right.equalTo(self.snp.rightMargin).constraint
            }
        }
    }

    open func split() -> Self {
        let count = subviews.count
        GLog.i("Splitting \(count) views ...")
        let weight = 1.0 / Float(count)
        let offset = -(totalGap + paddings.left + paddings.right) / Float(count)
        for view in subviews {
            if let weightable = view as? GWeightable {
                _ = weightable.width(weight: weight, offset: offset)
            } else {
                GLog.e("Invalid child view: \(view)")
            }
        }

        return self
    }

    open override func addSubview(_: UIView) {
        fatalError("Use addView() instead")
    }

    public func done() {
        // Ends chaining
    }
}

extension GHorizontalPanel: IView {
    public var size: CGSize {
        return helper.size
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
}
