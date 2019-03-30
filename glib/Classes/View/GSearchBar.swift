import UIKit

open class GSearchBar: UISearchBar, IView {
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

        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
//        _ = paddings(t: 10, l: 20, b: 10, r: 20)
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

    public func width(weight: Float, offset: Float = 0) -> Self {
        helper.width(weight: weight, offset: offset)
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

//    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
//    @discardableResult
//    open func onClick(_ command: @escaping (GButton) -> Void) -> Self {
//        onClick = command
//        addTarget(self, action: #selector(performClick), for: .touchUpInside)
//        return self
//    }
//
//    @objc open func performClick() {
//        if let callback = self.onClick {
//            callback(self)
//        }
//    }

    @discardableResult
    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

    @discardableResult
    public func placeholder(_ text: String) -> Self {
        placeholder = text
        return self
    }

    @discardableResult
    public func delegate(_ delegate: UISearchBarDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult
    public func focus() -> Self {
        becomeFirstResponder()
        return self
    }
}
