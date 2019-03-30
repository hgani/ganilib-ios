import UIKit

open class GVerticalPanel: UIView, IView {
    private var helper: ViewHelper!

    private var previousViewElement: UIView!
    private var previousConstraint: NSLayoutConstraint!
    private var event: EventHelper<GVerticalPanel>!

    private var totalGap = Float(0.0)

    public var size: CGSize {
        return helper.size
    }

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
        event = EventHelper(self)

        _ = paddings(top: 0, left: 0, bottom: 0, right: 0)

        addInitialBottomConstraint()
    }

    private func addInitialBottomConstraint() {
        previousConstraint = NSLayoutConstraint(item: self,
                                                attribute: .bottom,
                                                relatedBy: .equal,
                                                toItem: self,
                                                attribute: .top,
                                                multiplier: 1.0,
                                                constant: 0.0)
        previousConstraint.priority = UILayoutPriority(rawValue: 900) // Lower priority than fixed height
        addConstraint(previousConstraint)
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func clearViews() {
        // Remove it explicitly because it's not necessarily related to a  child view, thus won't be removed
        // as part of view.removeFromSuperview()
        removeConstraint(previousConstraint)
        addInitialBottomConstraint()

        previousViewElement = nil

        for view in subviews {
            view.removeFromSuperview()
        }
    }

    public func addView(_ child: UIView, top: Float = 0) {
        totalGap += top

        // The hope is this makes things more predictable
        child.translatesAutoresizingMaskIntoConstraints = false

        super.addSubview(child)
        initChildConstraints(child: child, top: top)
        adjustSelfConstraints(child: child)

        previousViewElement = child
    }

    public func clear() -> Self {
        clearViews()
        return self
    }

    @discardableResult
    public func append(_ child: UIView, top: Float = 0) -> Self {
        addView(child, top: top)
        return self
    }

    // See https://github.com/zaxonus/AutoLayScroll/blob/master/AutoLayScroll/ViewController.swift
    private func initChildConstraints(child: UIView, top: Float) {
        child.snp.makeConstraints { make in
            if previousViewElement == nil {
                make.top.equalTo(self.snp.topMargin).offset(top)
            } else {
                make.top.equalTo(previousViewElement.snp.bottom).offset(top)
            }

//            make.left.equalTo(self.snp.leftMargin)

            switch horizontalAlign {
            case .center: make.centerX.equalTo(self)
            case .right: make.right.equalTo(self.snp.rightMargin)
            case .left: make.left.equalTo(self.snp.leftMargin)
            }
        }
    }

    private func adjustSelfConstraints(child: UIView) {
        snp.makeConstraints { (make) -> Void in
            make.rightMargin.greaterThanOrEqualTo(child.snp.right)
        }

        if !helper.shouldHeightMatchParent() {
            removeConstraint(previousConstraint)

            previousConstraint = NSLayoutConstraint(item: child,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .bottomMargin,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
            previousConstraint.priority = UILayoutPriority(rawValue: 900)

            // At this point previousViewElement refers to the last subview, that is the one at the bottom.
            addConstraint(previousConstraint)
        }
    }

    @discardableResult
    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }

    @discardableResult
    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }

    @discardableResult
    public func width(weight: Float) -> Self {
        helper.width(weight: weight)
        return self
    }

    @discardableResult
    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    @discardableResult
    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }

    @discardableResult
    public func paddings(top: Float? = nil, left: Float? = nil, bottom: Float? = nil, right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

    @discardableResult
    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

    open override func addSubview(_: UIView) {
        fatalError("Use addView() instead")
    }

    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }

    public func hidden(_ hidden: Bool) -> Self {
        isHidden = hidden
        return self
    }

    public func onClick(_ command: @escaping (GVerticalPanel) -> Void) -> Self {
        event.onClick(command)
        return self
    }

    public func tap(_ command: (GVerticalPanel) -> Void) -> Self {
        command(self)
        return self
    }

    @discardableResult
    public func bg(image: UIImage?, repeatTexture: Bool) -> Self {
        helper.bg(image: image, repeatTexture: repeatTexture)
        return self
    }

    public func split() -> Self {
        let count = subviews.count
        GLog.i("Splitting \(count) views ...")
        let weight = 1.0 / Float(count)
        let offset = -(totalGap + paddings.top + paddings.bottom) / Float(count)
        for view in subviews {
            if let weightable = view as? GWeightable {
                _ = weightable.height(weight: weight, offset: offset)
            } else {
                GLog.e("Invalid child view: \(view)")
            }
        }

        return self
    }

    // MARK: - Alignment

    private var horizontalAlign: GAligner.GAlignerHorizontalGravity = .left

    public func align(_ align: GAligner.GAlignerHorizontalGravity) -> Self {
        horizontalAlign = align
        return self
    }

    public func done() {
        // Ends chaining
    }
}
