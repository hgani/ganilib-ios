
import UIKit
import IoniconsKit
import SwiftIconFont

open class GButton : UIButton {
    public init() {
        super.init(frame: .zero)

        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
        _ = self.padding(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func title(_ title : String, icon: Ionicons? = nil) -> GButton {
        let callButtonString = NSMutableAttributedString()
        
        if icon != nil {
            let callIcon = String.ionicon(with: icon!)
            let callIconAttributed = NSMutableAttributedString(string: callIcon, attributes: [NSFontAttributeName: UIFont.ionicon(of: 20)])
            callButtonString.append(callIconAttributed)
        }
        
        let callStringAttributed = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        callButtonString.append(callStringAttributed)
        
        self.setAttributedTitle(callButtonString, for: .normal)
        
        //self.layer.cornerRadius = 4
        
        return self
    }
    
    public func custom(_ title: String, iconString: String) -> GButton {
        let wrapper = UIView()
        wrapper.isUserInteractionEnabled = false
        
        let icon = UILabel()
        icon.isUserInteractionEnabled = false
        icon.font = UIFont.icon(from: .Ionicon, ofSize: 24.0)
        icon.text = String.fontIonIcon(iconString)
        icon.sizeToFit()
        
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.text = title
        label.sizeToFit()
        
        wrapper.addSubview(icon)
        wrapper.addSubview(label)
        self.addSubview(wrapper)
        
        wrapper.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
        
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(wrapper)
            make.left.equalTo(10)
            make.width.equalTo(16)
        }
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(wrapper)
            make.left.equalTo(icon.snp.right).offset(5)
        }
        
        //self.layer.cornerRadius = 4
        
        return self
    }
    
    public func width(_ width : Int) -> GButton {
        self.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(width)
        }
        return self
    }
    
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> GButton {
        let orig = self.contentEdgeInsets
        
        NSLog("INSETS: \(orig.top) \(orig.left) \(orig.bottom) \(orig.right)")
        
        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right
        
        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)

        return self
    }
    
    public func bgcolor(_ color: UIColor) -> GButton {
        self.backgroundColor = color
        self.titleLabel?.textColor = UIColor.white
        return self
    }
    
    public func click(_ target: Any, action: Selector) -> GButton {
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
    public func font(_ font: UIFont) -> GButton {
        self.titleLabel!.font = font
        return self
    }
    
    public func color(bg: UIColor?, text: UIColor? = nil) -> GButton {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        if let textColor = text {
            self.titleLabel?.textColor = textColor
        }
        return self
    }
    
    public func border(color : UIColor, width : Float = 1, corner : Float = 6) -> GButton {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = CGFloat(width)
        self.layer.cornerRadius = CGFloat(corner)
        return self
    }
}
