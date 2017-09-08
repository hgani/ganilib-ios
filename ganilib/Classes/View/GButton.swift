
import UIKit
//import IoniconsKit
import SwiftIconFont

open class GButton : UIButton {
    private var helper : ViewHelper!
    private var onClick : (() -> Void)?
    
    public init() {
        super.init(frame: .zero)
        
        self.helper = ViewHelper(self)
        
        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
        _ = self.padding(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    public func title(_ title : String, icon: Ionicons? = nil) -> GButton {
//        let callButtonString = NSMutableAttributedString()
//        
//        if icon != nil {
//            let callIcon = String.ionicon(with: icon!)
//            let callIconAttributed = NSMutableAttributedString(string: callIcon, attributes: [NSFontAttributeName: UIFont.ionicon(of: 20)])
//            callButtonString.append(callIconAttributed)
//        }
//        
//        //let callStringAttributed = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
//        let callStringAttributed = NSMutableAttributedString(string: title)
//
//        callButtonString.append(callStringAttributed)
//        
//        self.setAttributedTitle(callButtonString, for: .normal)
//        
//        return self
//    }
    
//    public func title(_ title: String) -> GButton {
//        let wrapper = UIView()
//        wrapper.isUserInteractionEnabled = false
////        wrapper.backgroundColor = UIColor.blue
//        
//        let icon = UILabel()
//        icon.isUserInteractionEnabled = false
////        icon.backgroundColor = UIColor.red
//        
////        if let str = iconString {
////            icon.font = UIFont.icon(from: .Ionicon, ofSize: 24.0)
////            icon.text = String.fontIonIcon(str)
////        }
//
//        icon.sizeToFit()
//        
//        self.myTitleLabel = GLabel().text(title)
//        myTitleLabel.isUserInteractionEnabled = false
//        //        label.backgroundColor = UIColor.yellow
////        label.text = title
//        label.sizeToFit()
//        
//        self.titleLabel = label
//        
//        wrapper.addSubview(icon)
//        wrapper.addSubview(label)
//        self.addSubview(wrapper)
//        
//        wrapper.snp.makeConstraints { (make) in
//            make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 10, 10, 10))
//        }
//        
////        icon.snp.makeConstraints { (make) in
////            make.top.equalTo(wrapper)
////            make.left.equalTo(10)
////            make.width.equalTo(16)
////        }
//        
//        label.snp.makeConstraints { (make) in
//            make.centerY.equalTo(wrapper)
//            make.left.equalTo(icon.snp.right).offset(5)
//        }
//        
//        return self
//    }

    public func title(_ title: String) -> Self {
        self.setTitle(title, for: .normal)
        return self
    }
    
    public func iconify() -> Self {
        self.parseIcon()
        return self
    }
    
//    public func custom(_ title: String, iconString: String) -> GButton {
//        let wrapper = UIView()
//        wrapper.isUserInteractionEnabled = false
//        
//        let icon = UILabel()
//        icon.font = UIFont.icon(from: .Ionicon, ofSize: 24.0)
//        icon.text = String.fontIonIcon(iconString)
//        icon.sizeToFit()
//        
//        let label = UILabel()
//        label.isUserInteractionEnabled = false
//        label.text = title
//        label.sizeToFit()
//        
//        wrapper.addSubview(icon)
//        wrapper.addSubview(label)
//        self.addSubview(wrapper)
//        
//        wrapper.snp.makeConstraints { (make) in
//            make.edges.equalTo(self).inset(UIEdgeInsetsMake(10, 10, 10, 10))
//        }
//        
//        icon.snp.makeConstraints { (make) in
//            make.top.equalTo(wrapper)
//            make.left.equalTo(10)
//            make.width.equalTo(16)
//        }
//        
//        label.snp.makeConstraints { (make) in
//            make.top.equalTo(wrapper)
//            make.left.equalTo(icon.snp.right).offset(5)
//        }
//        
//        return self
//    }
    
    public func width(_ width : Int) -> Self {
        helper.width(width)
        return self
    }
    
    public func height(_ height : Int) -> Self {
        helper.height(height)
        return self
    }
    
    public func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        let orig = self.contentEdgeInsets
        
        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right
        
        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)

        return self
    }
    
    public func bgcolor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        self.titleLabel?.textColor = UIColor.white
        return self
    }
    
    // NOTE: Deprecated. Use onClick() instead
//    public func click(_ target: Any, action: Selector) -> Self {
//        addTarget(target, action: action, for: .touchUpInside)
//        return self
//    }
    
    //typealias V = GButton
    public func spec(_ spec: GButtonSpec) -> Self {
        spec.initialize(self)
        return self
    }
    
    // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
    public func onClick(_ command: @escaping () -> Void) -> Self {
        self.onClick = command
        addTarget(self, action: #selector(performClick), for: .touchUpInside)
        return self
    }
    
    @objc private func performClick() {
        if let callback = self.onClick {
            callback()
        }
    }
    
    public func font(_ font: UIFont) -> Self {
        self.titleLabel!.font = font
        return self
    }
    
    public func textSize(_ size: Float) -> Self {
        return font(self.titleLabel!.font.withSize(CGFloat(size)))
    }
    
    public func text(size: Float?, align: UIControlContentHorizontalAlignment? = nil) -> Self {
        if let textSize = size {
            _ = font(self.titleLabel!.font.withSize(CGFloat(textSize)))
        }
        
        if let textAlign = align {
            self.contentHorizontalAlignment = textAlign;
        }
        
        return self
    }
    
    public func color(bg: UIColor?, text: UIColor? = nil) -> Self {
        if let bgColor = bg {
            self.backgroundColor = bgColor
        }
        if let textColor = text {
            self.setTitleColor(textColor, for: .normal)

//            Log.t("COLOR")
//            self.titleLabel!.textColor = textColor
        }
        return self
    }
    
    public func border(color : UIColor?, width : Float = 1, corner : Float = 6) -> Self {
//        if let c = color {
//            self.layer.borderColor = c.cgColor
//        }
//        self.layer.borderWidth = CGFloat(width)
//        self.layer.cornerRadius = CGFloat(corner)
        
        helper.border(color: color, width: width, corner: corner)
        return self
    }
    
    public func enabled(_ value : Bool) -> Self {
        self.isEnabled = value
        self.alpha = value ? 1.0 : 0.5
        return self
    }
    
    public func end() {
        // End chaining initialisation
    }
}

public protocol GButtonSpec {
    func initialize(_ button: GButton)
}
