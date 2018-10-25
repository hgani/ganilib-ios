
import SnapKit
import UIKit

public class ViewHelper {
    private unowned let view: UIView
    private var matchParentWidthMultiplier: Float?
    private var matchParentHeightMultiplier: Float?
    var paddings = Paddings(t: 0, l: 0, b: 0, r: 0)

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
                    heightConstraint = make.bottom.equalTo(superview.snp.bottomMargin).constraint
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
        if let w = width {
            self.width(w)
        }
        if let h = height {
            self.height(h)
        }
    }

    public func border(color: UIColor?, width: Float, corner: Float) {
        if let c = color {
            view.layer.borderColor = c.cgColor
        }
        view.layer.borderWidth = CGFloat(width)
        view.layer.cornerRadius = CGFloat(corner)
        view.layer.masksToBounds = true
    }

    public func paddings(t top: Float?, l left: Float?, b bottom: Float?, r right: Float?) {
        // Use our own variable to store the definitive values just in case layoutMargins gets changed directly,
        // which can get confusing.
        let orig = paddings

        let top = top ?? orig.t
        let left = left ?? orig.l
        let bottom = bottom ?? orig.b
        let right = right ?? orig.r

        paddings = Paddings(t: top, l: left, b: bottom, r: right)
        view.layoutMargins = paddings.toEdgeInsets()
    }
}

public enum LayoutSize {
    case matchParent, wrapContent
}

public struct Paddings {
    public let t: Float
    public let l: Float
    public let b: Float
    public let r: Float

    public func toEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsetsMake(CGFloat(t), CGFloat(l), CGFloat(b), CGFloat(r))
    }
}
