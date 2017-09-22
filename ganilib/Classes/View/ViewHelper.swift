
import UIKit
import SnapKit

open class ViewHelper {
    private let view: UIView
    private var matchParentWidthMultiplier: Float?
    private var matchParentHeightMultiplier: Float?
//    private var paddings = UIEdgeInsetsMake(0, 0, 0, 0)
//    let paddings = ViewPaddings()
    
    public init(_ view: UIView) {
        self.view = view
    }
    
    func didMoveToSuperview() {
        if let superview = view.superview {
            if let multiplier = matchParentWidthMultiplier {
                view.snp.makeConstraints { make in
                    if multiplier == 1 {
                        make.right.equalTo(superview.snp.rightMargin)  // Consume remaining space
//                        make.right.equalTo(superview)  // Consume remaining space
                    }
                    else {
                        make.width.equalTo(superview).multipliedBy(multiplier)
                    }
                }
            }
            if let multiplier = matchParentHeightMultiplier {
                view.snp.makeConstraints { make in
                    make.bottom.equalTo(superview)
                        //.multipliedBy(multiplier)
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
    
    public func width(weight: Float) {
        self.matchParentWidthMultiplier = weight
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
    }
    
//    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) {
//        paddings.update(t: top, l: left, b: bottom, r: right)
//    }
    
    public func paddings(t top: CGFloat?, l left: CGFloat?, b bottom: CGFloat?, r right: CGFloat?) {
        let orig = view.layoutMargins
        
        let top = top ?? orig.top
        let left = left ?? orig.left
        let bottom = bottom ?? orig.bottom
        let right = right ?? orig.right
        
        view.layoutMargins = UIEdgeInsetsMake(top, left, bottom, right)
    }
}

//public class ViewPaddings {
//    private var paddings = UIEdgeInsetsMake(0, 0, 0, 0)
//    
//    var top: CGFloat {
//        get {
//            return paddings.top
//        }
//    }
//    var bottom: CGFloat {
//        get {
//            return paddings.bottom
//        }
//    }
//    var left: CGFloat {
//        get {
//            return paddings.left
//        }
//    }
//    var right: CGFloat {
//        get {
//            return paddings.right
//        }
//    }
//    
//    public func update(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) {
//        let orig = self.paddings
//        
//        let top = top ?? orig.top
//        let left = left ?? orig.left
//        let bottom = bottom ?? orig.bottom
//        let right = right ?? orig.right
//        
//        self.paddings = UIEdgeInsetsMake(top, left, bottom, right)
//    }
//}

public enum LayoutSize {
    case matchParent, wrapContent
}

