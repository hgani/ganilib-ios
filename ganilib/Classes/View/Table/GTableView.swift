
import UIKit

open class GTableView: UITableView, GContainer {
    private var helper: ViewHelper!
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        initialize()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.helper = ViewHelper(self)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }
    
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    public func source(_ source: UITableViewDataSource) -> Self {
        self.dataSource = source
        return self
    }
    
    public func register(_ type: GTableViewCell.Type) -> Self {
        register(type.nib(), forCellReuseIdentifier: type.reuseIdentifier())
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
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = CGFloat(estimate)
        return self
    }
    
    public func autoHeaderHeight(estimate: Float) -> Self {
        self.sectionHeaderHeight = UITableViewAutomaticDimension
        self.estimatedSectionHeaderHeight = CGFloat(estimate)
        return self
    }
    
    public func cellInstance<T: GTableViewCell>(of type: T.Type, style: UITableViewCellStyle = .default) -> T {
        if let cell = self.dequeueReusableCell(withIdentifier: type.reuseIdentifier()) as? T {
            return cell
        }
        return type.init(style: style)
    }
    
    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    public func end() {
        // Ends chaining
    }
}

open class GTableViewCell: UITableViewCell {
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
        self.helper = ViewHelper(self.contentView)
//        self.contentView.addSubview(container)
    }
    
    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    public func end() {
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
}

open class GTableViewCustomCell: GTableViewCell {
    private let container = GVerticalPanel()
    
    public convenience init() {
        self.init(style: .default)
    }
    
    public required init(style: UITableViewCellStyle) {
        super.init(style: style)
        
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        self.contentView.addSubview(container)
    }
    
    open override func didMoveToSuperview() {
        container.snp.makeConstraints { (make) -> Void in
            // Snap the panel's vertical edges so that the tableView can determine the dynamic height of each row
            // See https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
//            make.top.equalTo(self.contentView).offset(paddings.top)
//            make.bottom.equalTo(self.contentView).offset(-paddings.bottom)
//            
//            make.left.equalTo(self.contentView).offset(paddings.left)
//            make.right.equalTo(self.contentView).offset(-paddings.right)
            make.top.equalTo(self.contentView.snp.topMargin)
            make.bottom.equalTo(self.contentView.snp.bottomMargin)
            
            make.left.equalTo(self.contentView.snp.leftMargin)
            make.right.equalTo(self.contentView.snp.rightMargin)
        }
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        container.addView(view, top: top)
    }
    
    public func append(_ view: UIView, top : CGFloat? = nil) -> Self {
        container.addView(view, top: top)
        return self
    }
    
    public func color(bg: UIColor) -> Self {
        contentView.backgroundColor = bg
        return self
    }
    
    public func interactive(_ value: Bool) -> Self {
        self.isUserInteractionEnabled = value
        return self
    }
}

open class GHeaderFooterView: UIView {
    private let container = GVerticalPanel()
    
    public init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    public func initialize() {
        self.addSubview(container)
        
        container.snp.makeConstraints { make in
            // Snap the panel's vertical edges so that the tableView can determine the dynamic height of each row
            // See https://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        
        self.backgroundColor = .white
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
    
    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        _ = container.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    public func color(bg: UIColor) -> Self {
        _ = container.color(bg: bg)
        return self
    }
    
    public func end() {
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
