
import UIKit
import SnapKit

public class ViewHelper {
    private unowned let view: UIView
    private var matchParentWidthMultiplier: Float?
    private var matchParentHeightMultiplier: Float?
    var paddings = Paddings(t: 0, l: 0, b: 0, r: 0)
//    private var paddings = UIEdgeInsetsMake(0, 0, 0, 0)
    
    public init(_ view: UIView) {
        self.view = view
    }
    
    func didMoveToSuperview(debug: Bool = false) {
        updateWidthConstraints(debug: debug)
        updateHeightConstraints()
    }
    
    private func updateWidthConstraints(offset: Float = 0, debug: Bool = false) {
        if let superview = view.superview {
            if let multiplier = matchParentWidthMultiplier {
                view.snp.makeConstraints { make in
                    if debug {
                        GLog.t("updateWidthConstraints() with multiplier \(multiplier)")
                    }
                    if multiplier == 1 {
                        make.right.equalTo(superview.snp.rightMargin)  // Consume remaining space
                    }
                    else {
                        make.width.equalTo(superview).multipliedBy(multiplier).offset(offset)
                    }
                }
            }
        }
    }
    
    private func updateHeightConstraints() {
        if let superview = view.superview {
            if let multiplier = matchParentHeightMultiplier {
                view.snp.makeConstraints { make in
                    make.bottom.equalTo(superview.snp.bottomMargin)
                }
            }
        }
    }
    
    func shouldWidthMatchParent() -> Bool {
        return matchParentWidthMultiplier != nil
    }
    
    func shouldHeightMatchParent() -> Bool {
        return matchParentHeightMultiplier != nil
    }
    
    public func width(_ width: Int) {
        self.matchParentWidthMultiplier = nil
        view.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(width)
        }

    }
    
    private func nothingToDo() {
        // Nothing to do
    }
    
    public func width(_ width: LayoutSize) {
        switch width {
        case .matchParent:
            self.matchParentWidthMultiplier = 1
        case .wrapContent:
            nothingToDo()
        }
    }
    
    public func width(weight: Float, offset: Float = 0) {
        self.matchParentWidthMultiplier = weight
        updateWidthConstraints(offset: offset)
    }
    
    public func height(_ height : Int) {
        self.matchParentHeightMultiplier = nil
        view.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(height)
        }
    }
    
    public func height(_ height: LayoutSize) {
        switch height {
        case .matchParent:
            self.matchParentHeightMultiplier = 1
        case .wrapContent:
            nothingToDo()
        }
    }
    
    public func size(width: Int?, height: Int?) {
        if let w = width {
            self.width(w)
        }
        if let h = height {
            self.height(h)
        }
    }
    
    public func border(color : UIColor?, width : Float, corner : Float)  {
        if let c = color {
            view.layer.borderColor = c.cgColor
        }
        view.layer.borderWidth = CGFloat(width)
        view.layer.cornerRadius = CGFloat(corner)
        view.layer.masksToBounds = true
    }
    
    public func paddings(t top: Float?, l left: Float?, b bottom: Float?, r right: Float?) {
        // Use our own variable to store the definitive values just in case layoutMargins gets changed directly,
        // which can get confusing.
        let orig = self.paddings
        
        let top = top ?? orig.t
        let left = left ?? orig.l
        let bottom = bottom ?? orig.b
        let right = right ?? orig.r
        
//        self.paddings = UIEdgeInsetsMake(top, left, bottom, right)
        self.paddings = Paddings(t: top, l: left, b: bottom, r: right)
        view.layoutMargins = paddings.toEdgeInsets()
    }
}

public enum LayoutSize {
    case matchParent, wrapContent
}

public struct Paddings {
    public let t: Float
    public let l: Float
    public let b: Float
    public let r: Float
    
    public func toEdgeInsets() -> UIEdgeInsets {
        return UIEdgeInsetsMake(CGFloat(t), CGFloat(l), CGFloat(b), CGFloat(r))
    }
}
