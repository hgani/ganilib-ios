
import SwiftIconFont
import UIKit

open class GLabel: UILabel, IView {
    private var helper: ViewHelper!
    private var isUnderlined = false
    private var onClick: ((GLabel) -> Void)?
    var paddings = Paddings(t: 0, l: 0, b: 0, r: 0)
    var clickRecognizer: UITapGestureRecognizer?

    private var lineSpacing: Int?
    private var align: NSTextAlignment?
    private var maxLines: Int?

    public var size: CGSize {
        return helper.size
    }

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

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }

    @discardableResult
    public func color(bg: UIColor) -> Self {
        return color(bg: bg, text: nil)
    }

    @discardableResult
    public func color(bg: UIColor?, text: UIColor? = nil) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        if let textColor = text {
            self.textColor = textColor
        }
        return self
    }

    @discardableResult
    public func lineSpacing(_ spacing: Int) -> Self {
        lineSpacing = spacing
        return self
    }

    @discardableResult
    public func maxLines(_ maxLines: Int) -> Self {
        numberOfLines = maxLines
        self.maxLines = maxLines
        return self
    }

    @discardableResult
    public func text(_ text: String) -> Self {
        if maxLines == nil {
            numberOfLines = 0
        }

        if let spacing = lineSpacing {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = CGFloat(spacing)
            paragraphStyle.lineBreakMode = lineBreakMode
            paragraphStyle.alignment = textAlignment

            let attrString = NSMutableAttributedString(string: text)
            attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))

            attributedText = attrString

//            if let align = self.align {
//                self.align(align)
//            }
        } else {
            self.text = text
        }

        return self
    }

    @discardableResult
    public func icon(_ icon: String, size: CGFloat? = nil) -> Self {
        numberOfLines = 0
        text = icon
        if let s = size {
            font = font.withSize(s)
        }
        parseIcon()
        return self
    }

    // Has to be called before text()
    @discardableResult
    public func font(_ font: UIFont?, size: Float? = nil, traits: UIFontDescriptorSymbolicTraits...) -> Self {
        var f = (font ?? self.font!)
        // For safety, don't touch it if no traits is specified
        if traits.count > 0 {
            f = f.withTraits(traits)
        }
        if let s = size {
            f = f.withSize(CGFloat(s))
        }
        self.font = f
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

    @discardableResult
    public func align(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        align = alignment
        return self
    }

//    public func spec(_ spec : GLabelSpec) -> Self {
//        spec.decorate(self)
//        return self
//    }

    public func specs(_ specs: GLabelSpec...) -> Self {
        for spec in specs {
            spec.decorate(self)
        }
        return self
    }

    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    public func onClick(_ command: @escaping (GLabel) -> Void) -> Self {
        onClick = command
        isUserInteractionEnabled = true

        if let recognizer = clickRecognizer {
            removeGestureRecognizer(recognizer) // Clear previous
        }
        clickRecognizer = UITapGestureRecognizer(target: self, action: #selector(performClick))
        addGestureRecognizer(clickRecognizer!)

        return self
    }

    @objc private func performClick() {
        if let callback = self.onClick {
            callback(self)
        }
    }

    public func underline() -> Self {
        isUnderlined = true
        return self
    }

    public func paddings(t top: Float?, l left: Float?, b bottom: Float?, r right: Float?) -> Self {
        let orig = paddings

        let top = top ?? orig.t
        let left = left ?? orig.l
        let bottom = bottom ?? orig.b
        let right = right ?? orig.r

        paddings = Paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

    public func done() {
        // End chaining
    }

//    // See https://stackoverflow.com/questions/27459746/adding-space-padding-to-a-uilabel
//    override open var intrinsicContentSize: CGSize {
//        let size = super.intrinsicContentSize
//        return CGSize(width: size.width + CGFloat(paddings.l + paddings.r),
//                      height: size.height + CGFloat(paddings.t + paddings.b))
//    }

    // From https://stackoverflow.com/questions/21167226/resizing-a-uilabel-to-accommodate-insets/21267507#21267507
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textInsets = paddings.toEdgeInsets()
        let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
    }

    open override func draw(_ rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, paddings.toEdgeInsets()))

        if isUnderlined {
            let startingPoint = CGPoint(x: rect.minX, y: rect.maxY - 2)
            let endingPoint = CGPoint(x: rect.maxX, y: rect.maxY - 2)

            let path = UIBezierPath()

            path.move(to: startingPoint)
            path.addLine(to: endingPoint)

            let traits = CTFontGetSymbolicTraits(font)
            let isBold = (traits == CTFontSymbolicTraits.traitBold)
            path.lineWidth = isBold ? 2.0 : 1.0

            textColor.setStroke()

            path.stroke()
        }
    }
}

// From https://gist.github.com/zyrx/67fa2f42b567d1d4c8fef434c7987387
extension GLabel {
    public func copyable() -> Self {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
        return self
    }

    open override var canBecomeFirstResponder: Bool {
        return true
    }

    @objc private func showMenu(sender _: AnyObject?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }

    open override func copy(_: Any?) {
        let board = UIPasteboard.general
        board.string = text
        let menu = UIMenuController.shared
        menu.setMenuVisible(false, animated: true)
    }

    open override func canPerformAction(_ action: Selector, withSender _: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy)
    }
}

public class GLabelSpec {
    private var decorator: ((GLabel) -> Void)

    public init(_ decorator: @escaping ((GLabel) -> Void)) {
        self.decorator = decorator
    }

    func decorate(_ view: GLabel) {
        decorator(view)
    }
}
