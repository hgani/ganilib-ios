import SnapKit
import UIKit

public class ViewHelper {
    private unowned let view: UIView
    private var matchParentWidthMultiplier: Float?
    private var matchParentHeightMultiplier: Float?
    var paddings = Paddings(top: 0, left: 0, bottom: 0, right: 0)

    private var widthConstraint: Constraint?
    private var heightConstraint: Constraint?

    public var size: CGSize {
        return view.bounds.size
    }

    public var screen: GScreen? {
        var nextResponder = view.next
        while let responder = nextResponder {
            if let screen = responder as? GScreen {
                return screen
            }
            nextResponder = responder.next
        }
        return nil
    }

    public init(_ view: UIView) {
        self.view = view
        view.layoutMargins = paddings.toEdgeInsets()
    }

    func didMoveToSuperview(debug: Bool = false) {
        updateWidthConstraints(debug: debug)
        updateHeightConstraints()
    }

    private func updateWidthConstraints(offset: Float = 0, debug: Bool = false) {
        if let superview = view.superview {
            if let multiplier = matchParentWidthMultiplier {
                view.snp.makeConstraints { make in
                    if debug {
                        GLog.t("updateWidthConstraints() with multiplier \(multiplier)")
                    }

                    if multiplier == 1 {
                        widthConstraint = make.right.equalTo(superview.snp.rightMargin).constraint // Consume remaining space
                    } else {
                        widthConstraint = make.width.equalTo(superview).multipliedBy(multiplier).offset(offset).constraint
                    }
                }
            }
        }
    }

    private func updateHeightConstraints() {
        if let superview = view.superview {
            if let multiplier = matchParentHeightMultiplier {
                view.snp.makeConstraints { make in
                    if multiplier == 1 {
                        heightConstraint = make.bottom.equalTo(superview.snp.bottomMargin).constraint
                    }
                }
            }
        }
    }

    func shouldWidthMatchParent() -> Bool {
        return matchParentWidthMultiplier != nil
    }

    func shouldHeightMatchParent() -> Bool {
        return matchParentHeightMultiplier != nil
    }

    private func nothingToDo() {
        // Nothing to do
    }

    private func resetWidth() {
        widthConstraint?.deactivate()
        widthConstraint = nil
        matchParentWidthMultiplier = nil
    }

    public func width(_ width: Int) {
        resetWidth()

        matchParentWidthMultiplier = nil
        view.snp.makeConstraints { (make) -> Void in
            widthConstraint = make.width.equalTo(width).constraint
        }

        updateWidthConstraints()
    }

    public func width(_ width: LayoutSize) {
        resetWidth()

        switch width {
        case .matchParent:
            matchParentWidthMultiplier = 1
        case .wrapContent:
            nothingToDo()
        }

        updateWidthConstraints()
    }

    public func width(weight: Float, offset: Float = 0) {
        resetWidth()

        matchParentWidthMultiplier = weight
        updateWidthConstraints(offset: offset)
    }

    private func resetHeight() {
        heightConstraint?.deactivate()
        heightConstraint = nil
        matchParentHeightMultiplier = nil
    }

    public func height(_ height: Int) {
        resetHeight()

        view.snp.makeConstraints { (make) -> Void in
            heightConstraint = make.height.equalTo(height).constraint
        }

        updateHeightConstraints()
    }

    public func height(_ height: LayoutSize) {
        resetHeight()

        switch height {
        case .matchParent:
            matchParentHeightMultiplier = 1
        case .wrapContent:
            nothingToDo()
        }

        updateHeightConstraints()
    }

    public func size(width: Int?, height: Int?) {
        if let widthValue = width {
            self.width(widthValue)
        }
        if let heightValue = height {
            self.height(heightValue)
        }
    }

    public func border(color: UIColor?, width: Float, corner: Float) {
        if let colorValue = color {
            view.layer.borderColor = colorValue.cgColor
        }
        view.layer.borderWidth = CGFloat(width)
        view.layer.cornerRadius = CGFloat(corner)
        view.layer.masksToBounds = true
    }

    public func paddings(t top: Float?, l left: Float?, b bottom: Float?, r right: Float?) {
        // Use our own variable to store the definitive values just in case layoutMargins gets changed directly,
        // which can get confusing.
        paddings = Paddings.from(top: top, left: left, bottom: bottom, right: right, orig: paddings)

//        let orig = paddings
//
//        let top = top ?? orig.top
//        let left = left ?? orig.left
//        let bottom = bottom ?? orig.bottom
//        let right = right ?? orig.right
//
//        paddings = Paddings(top: top, left: left, bottom: bottom, right: right)
        view.layoutMargins = paddings.toEdgeInsets()
    }

    public static func setResistance(view: UIView, axis: NSLayoutConstraint.Axis, priority: UILayoutPriority) {
        view.setContentCompressionResistancePriority(priority, for: axis)

        for subview in view.subviews {
            setResistance(view: subview, axis: axis, priority: priority)
        }
    }

    public static func decreaseResistance(view: UIView, axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        let previousResistance = view.contentCompressionResistancePriority(for: axis)
        setResistance(view: view, axis: axis, priority: .defaultLow)
        return previousResistance
    }

    public static func setHugging(view: UIView, axis: NSLayoutConstraint.Axis, priority: UILayoutPriority) {
        view.setContentHuggingPriority(priority, for: axis)

        for subview in view.subviews {
            setHugging(view: subview, axis: axis, priority: priority)
        }
    }

    public static func increaseHugging(view: UIView, axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        let previousHugging = view.contentHuggingPriority(for: axis)
        setHugging(view: view, axis: axis, priority: .defaultHigh)
        return previousHugging
    }

    public static func decreaseHugging(view: UIView, axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        let previousHugging = view.contentHuggingPriority(for: axis)
        setHugging(view: view, axis: axis, priority: .defaultLow)
        return previousHugging
    }

    public static func minimalHugging(view: UIView, axis: NSLayoutConstraint.Axis) -> UILayoutPriority {
        let previousHugging = view.contentHuggingPriority(for: axis)
        setHugging(view: view, axis: axis, priority: UILayoutPriority(rawValue: 1))
        return previousHugging
    }
}

public enum LayoutSize {
    case matchParent, wrapContent
}

public struct Paddings {
    public let top: Float
    public let left: Float
    public let bottom: Float
    public let right: Float

    public func toEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(top), left: CGFloat(left), bottom: CGFloat(bottom), right: CGFloat(right))
    }

    static func from(top: Float?, left: Float?, bottom: Float?, right: Float?, orig: Paddings) -> Paddings {
        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right

        return Paddings(top: top, left: left, bottom: bottom, right: right)
    }
}
