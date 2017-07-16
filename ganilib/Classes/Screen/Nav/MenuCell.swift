import UIKit
import SnapKit
import SwiftIconFont

class MenuCell: UITableViewCell {
    var titleLabel: UILabel!
    var iconLabel: UILabel!
    
    var menu: MenuItem? {
        didSet {
            if let m = menu {
                titleLabel.text = m.title
                iconLabel.text = m.icon
                iconLabel.parseIcon()
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        
        iconLabel = UILabel(frame: .zero)
        contentView.addSubview(iconLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        iconLabel.font = iconLabel.font.withSize(20)
        iconLabel.sizeToFit()
        
        iconLabel.snp.makeConstraints { (make) -> Void in
            make.topMargin.equalTo(8)
            make.leftMargin.equalTo(8)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.topMargin.equalTo(8)
            make.left.equalTo(iconLabel.snp.right).offset(8)
        }
        
    }
}
