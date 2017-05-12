
import UIKit
import IoniconsKit

class GButton : UIButton {
    init() {
        super.init(frame: .zero)

        // Make sure that contentEdgeInsets' values is always initialized properly (i.e. non-zero)
        _ = self.padding(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func title(_ title : String, icon: Ionicons? = nil) -> GButton {
        let callButtonString = NSMutableAttributedString()
        
        if icon != nil {
            let callIcon = String.ionicon(with: icon!)
            let callIconAttributed = NSMutableAttributedString(string: callIcon, attributes: [NSFontAttributeName: UIFont.ionicon(of: 20)])
            callButtonString.append(callIconAttributed)
        }
        
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

        return self
    }
    
    func bgcolor(_ color: UIColor) -> GButton {
        self.backgroundColor = color
        self.titleLabel?.textColor = UIColor.white
        return self
    }
    
    func click(_ target: Any, action: Selector) -> GButton {
        addTarget(target, action: action, for: .touchUpInside)
        return self
    }
    
    func font(_ font: UIFont) -> GButton {
        self.titleLabel!.font = font
        return self
    }
}
