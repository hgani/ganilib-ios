public protocol MenuCellType {
    func update(item: MenuItem)
}

open class MenuCell: GTableViewCustomCell, MenuCellType {
    public let icon = GLabel()
    public let title = GLabel()
    
    required public init(style: UITableViewCellStyle) {
        super.init(style: style)
        populate()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        populate()
    }
    
    open func populate() {
        self
            .paddings(t: 8, l: 14, b: 8, r: 14)
            .append(GHorizontalPanel().paddings(t: 5, l: 10, b: 5, r: 10).append(icon).append(title, left: 5))
            .done()
    }
    
    open func update(item: MenuItem) {
        if let iconText = item.icon {
            _ = self.icon.icon(iconText)
        }
        _ = self.title.text(item.title)
        
        self.isUserInteractionEnabled = item.hasAction()
        
        setNeedsLayout()
    }
}

//class MenuCell: UITableViewCell {
//    var titleLabel: UILabel!
//    var iconLabel: UILabel!
//
//    var menu: MenuItem? {
//        didSet {
//            if let m = menu {
//                titleLabel.text = m.title
//                iconLabel.text = m.icon
//                iconLabel.parseIcon()
//                setNeedsLayout()
//            }
//        }
//    }
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        titleLabel = UILabel(frame: .zero)
//        titleLabel.textColor = UIColor.black
//        contentView.addSubview(titleLabel)
//
//        iconLabel = UILabel(frame: .zero)
//        contentView.addSubview(iconLabel)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        titleLabel.sizeToFit()
//        iconLabel.font = iconLabel.font.withSize(20)
//        iconLabel.sizeToFit()
//
//        iconLabel.snp.makeConstraints { (make) -> Void in
//            make.topMargin.equalTo(8)
//            make.leftMargin.equalTo(8)
//        }
//        titleLabel.snp.makeConstraints { (make) -> Void in
//            make.topMargin.equalTo(8)
//            make.left.equalTo(iconLabel.snp.right).offset(8)
//        }
//
//    }
//}

