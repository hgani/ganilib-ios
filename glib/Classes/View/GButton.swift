import SwiftIconFont
import UIKit

open class GButton: UIButton, IView {
    fileprivate var helper: ViewHelper!
    private var onClick: ((GButton) -> Void)?
    var paddings = Paddings(top: 0, left: 0, bottom: 0, right: 0)

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

        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
        _ = paddings(top: 10, left: 20, bottom: 10, right: 20)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func title(_ title: String) -> Self {
        titleLabel!.numberOfLines = 0
        setTitle(title, for: .normal)
        return self
    }

    public func iconify() -> Self {
        parseIcon()
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

    @discardableResult
    public func paddings(top: Float?, left: Float?, bottom: Float?, right: Float?) -> Self {
//    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
//        let orig = contentEdgeInsets
//
//        let top = top ?? orig.top
//        let left = left ?? orig.left
//        let bottom = bottom ?? orig.bottom
//        let right = right ?? orig.right
//
//        contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)

        paddings = Paddings.from(top: top, left: left, bottom: bottom, right: right, orig: paddings)
        contentEdgeInsets = paddings.toEdgeInsets()
        return self
    }

    @discardableResult
    public func specs(_ specs: GButtonSpec...) -> Self {
        for spec in specs {
            spec.decorate(self)
        }
        return self
    }

    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    @discardableResult
    open func onClick(_ command: @escaping (GButton) -> Void) -> Self {
        onClick = command
        addTarget(self, action: #selector(performClick), for: .touchUpInside)
        return self
    }

    @objc open func performClick() {
        if let callback = self.onClick {
            callback(self)
        }
    }

    @discardableResult
    public func font(_ font: UIFont?, size: Float? = nil, traits: UIFontDescriptor.SymbolicTraits...) -> Self {
        var newFont = (font ?? titleLabel!.font).withTraits(traits)
        if let newSize = size {
            newFont = newFont.withSize(CGFloat(newSize))
        }
        titleLabel!.font = newFont
        return self
    }

    @discardableResult
    public func align(_ alignment: NSTextAlignment) -> Self {
        // The following works better when the button has multi-line text compared to
        // self.contentHorizontalAlignment which only aligns the label itself rather than the label's text
        titleLabel?.textAlignment = alignment
        return self
    }

    @discardableResult
    public func color(bg: UIColor?, text: UIColor? = nil) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        if let textColor = text {
            setTitleColor(textColor, for: .normal)
        }
        return self
    }

    @discardableResult
    public func color(bg: UIColor) -> Self {
        return color(bg: bg, text: nil)
    }

    @discardableResult
    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }

    @discardableResult
    public func enabled(_ value: Bool) -> Self {
        isEnabled = value
        alpha = value ? 1.0 : 0.5
        return self
    }

    @discardableResult
    public func hidden(_ hidden: Bool) -> Self {
        isHidden = hidden
        return self
    }

    public func done() {
        // End chaining
    }
}

extension GButton: GWeightable {
    public func width(weight: Float, offset: Float = 0) -> Self {
        helper.width(weight: weight, offset: offset)
        return self
    }

    public func height(weight: Float, offset: Float = 0) -> Self {
        helper.height(weight: weight, offset: offset)
        return self
    }
}

public class GButtonSpec {
    private var decorator: ((GButton) -> Void)

    public init(_ decorator: @escaping ((GButton) -> Void)) {
        self.decorator = decorator
    }

    func decorate(_ view: GButton) {
        decorator(view)
    }
}
