
import UIKit

open class GTableView: UITableView, IContainer {
    private var helper: ViewHelper!

    // Useful for making sure an unattached delegate object sticks around.
    private var retainedDelegate: UITableViewDelegate?

    public var size: CGSize {
        return helper.size
    }

    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
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

    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

    public func delegate(_ delegate: UITableViewDelegate, retain: Bool = false) -> Self {
        self.delegate = delegate
        if retain {
            retainedDelegate = delegate
        }
        return self
    }

    public func source(_ source: UITableViewDataSource) -> Self {
        dataSource = source
        return self
    }

    public func register(nibType: GTableViewCell.Type) -> Self {
        register(nibType.nib(), forCellReuseIdentifier: nibType.reuseIdentifier())
        return self
    }

    public func reload() -> Self {
        reloadData()
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

    public func autoRowHeight(estimate: Float) -> Self {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = CGFloat(estimate)
        return self
    }

    public func autoHeaderHeight(estimate: Float) -> Self {
        sectionHeaderHeight = UITableViewAutomaticDimension
        estimatedSectionHeaderHeight = CGFloat(estimate)
        return self
    }

    public func cellInstance<T: GTableViewCell>(of type: T.Type, style: UITableViewCellStyle = .default) -> T {
        var cell: T
        if let safeCell = self.dequeueReusableCell(withIdentifier: type.reuseIdentifier()) as? T {
            cell = safeCell
        } else {
            cell = type.init(style: style)
        }
        cell.tableView = self
        return cell
    }

    public func paddings(top: Float? = nil, left: Float? = nil, bottom: Float? = nil, right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

    public func separator(_ style: UITableViewCellSeparatorStyle) -> Self {
        separatorStyle = style
        return self
    }

    public func withRefresher(_ refresher: GRefreshControl) -> Self {
        addSubview(refresher)
        return self
    }

    public var screen: GScreen? {
        return helper.screen
    }

    public func done() {
        // Ends chaining
    }
}

open class GTableViewCell: UITableViewCell {
    public fileprivate(set) weak var tableView: GTableView?
    private var helper: ViewHelper!

    public convenience init() {
        self.init(style: .default)
    }

    public required init(style: UITableViewCellStyle) {
        super.init(style: style, reuseIdentifier: type(of: self).nibName())

        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    private func initialize() {
        helper = ViewHelper(contentView)
    }

    public func paddings(top: Float? = nil, left: Float? = nil, bottom: Float? = nil, right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

    public func done() {
        // End call chaining
    }

    static func nibName() -> String {
        return String(describing: self)
    }

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: nibName(), bundle: nil)
    }

    public func interactive(_ value: Bool) -> Self {
        isUserInteractionEnabled = value

        selectionStyle = .none
        return self
    }

    public func selectionStyle(_ value: UITableViewCellSelectionStyle) -> Self {
        selectionStyle = value
        return self
    }
}

open class GTableViewCustomCell: GTableViewCell {
    private let container = GVerticalPanel()

//    public convenience init() {
//        self.init(style: .default)
//    }

    public required init(style: UITableViewCellStyle) {
        super.init(style: style)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        contentView.addSubview(container)
        initContent()
    }

    open func initContent() {
        // To be overridden
    }

    open override func didMoveToSuperview() {
        container.snp.makeConstraints { (make) -> Void in
            // Snap the panel's vertical edges so that the tableView can determine the dynamic height of each row
            // See https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
            //
            // For some reason contentView's leftMargin and rightMargin are always non-zero, so for predictability,
            // it's better to stick everything to the non-margin borders and set paddings on `container` instead.
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom)

            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
        }
    }

    @discardableResult
    public override func paddings(top: Float? = nil, left: Float? = nil, bottom: Float? = nil, right: Float? = nil) -> Self {
        _ = container.paddings(top: top, left: left, bottom: bottom, right: right)
        return self
    }

    public func addView(_ view: UIView, top: CGFloat? = nil) {
        container.addView(view, top: top)
    }

    public func append(_ view: UIView, top: CGFloat? = nil) -> Self {
        container.addView(view, top: top)
        return self
    }

    @discardableResult
    public func color(bg: UIColor) -> Self {
        contentView.backgroundColor = bg
        return self
    }
}

open class GHeaderFooterView: UIView {
    private let container = GVerticalPanel()

    public init() {
        super.init(frame: .zero)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    public func initialize() {
        addSubview(container)

        container.snp.makeConstraints { make in
            // Snap the panel's vertical edges so that the tableView can determine the dynamic height of each row
            // See https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
            make.top.equalTo(self)
            make.bottom.equalTo(self)

            make.left.equalTo(self)
            make.right.equalTo(self)
        }

        backgroundColor = .white
    }

    public func clearViews() {
        container.clearViews()
    }

    public func addView(_ view: UIView, top: CGFloat? = nil) {
        container.addView(view, top: top)
    }

    public func clear() -> Self {
        clearViews()
        return self
    }

    public func append(_ view: UIView, top: CGFloat? = nil) -> Self {
        addView(view, top: top)
        return self
    }

    public func paddings(top: Float? = nil, left: Float? = nil, bottom: Float? = nil, right: Float? = nil) -> Self {
        _ = container.paddings(top: top, left: left, bottom: bottom, right: right)
        return self
    }

    public func color(bg: UIColor) -> Self {
        _ = container.color(bg: bg)
        return self
    }

    public func done() {
        // Ends chaining
    }

//    open override func didMoveToSuperview() {
//        container.snp.makeConstraints { (make) -> Void in
//            // Snap the panel's vertical edges so that the tableView can determine the dynamic height of each row
//            // See https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
//            make.top.equalTo(self.contentView).offset(paddings.top)
//            make.bottom.equalTo(self.contentView).offset(-paddings.bottom)
//
//            make.left.equalTo(self.contentView).offset(paddings.left)
//            make.right.equalTo(self.contentView).offset(-paddings.right)
//        }
//    }
}
