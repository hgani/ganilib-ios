
import UIKit

open class GImageView : UIImageView {
    public func namedImage(_ name: String) -> UIImageView {
        self.image = UIImage(named: name)
        return self
    }
    
    /*
    init() {
        super.init(frame: .zero)

        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
        _ = self.padding(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")

    }
    
    func title(_ title : String, icon: Ionicons) -> GButton {
        let callButtonString = NSMutableAttributedString()
        
        let callIcon = String.ionicon(with: icon)
        let callIconAttributed = NSMutableAttributedString(string: callIcon, attributes: [NSFontAttributeName: UIFont.ionicon(of: 20)])
        callButtonString.append(callIconAttributed)
        
        let callStringAttributed = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        callButtonString.append(callStringAttributed)
        
        self.setAttributedTitle(callButtonString, for: .normal)
        
        self.layer.cornerRadius = 4
        
        return self
    }
    
    func padding(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> GButton {
        let orig = self.contentEdgeInsets
        
        NSLog("INSETS: \(orig.top) \(orig.left) \(orig.bottom) \(orig.right)")
        
        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right
        
        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        //self.titleEdgeInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)

        return self
    }
    
    /*
    func title(_ title : String) -> GButton {
        setTitle(title,for: .normal)
        return self
    }
    */
    func bgcolor(_ color: UIColor) -> GButton {
        self.backgroundColor = color
        self.titleLabel?.textColor = UIColor.white

        /*
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10.0*/
        return self
    }
    
    func click(_ target: Any, action: Selector) -> GButton {
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
 */
}
