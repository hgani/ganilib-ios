
import UIKit
import SnapKit


open class ViewHelper {
    private let view: UIView
    private var matchParentWidthMultiplier: Float?
    private var matchParentHeightMultiplier: Float?
//    private var paddings = UIEdgeInsetsMake(0, 0, 0, 0)
    
    public init(_ view: UIView) {
        self.view = view
    }
    
    func didMoveToSuperview() {
        if let superview = view.superview {
            if let multiplier = matchParentWidthMultiplier {
                view.snp.makeConstraints { make in
                    if multiplier == 1 {
                        make.right.equalTo(superview)  // Consume remaining space
                    }
                    else {
                        make.width.equalTo(superview).multipliedBy(multiplier)
                    }
                }
            }
            if let multiplier = matchParentHeightMultiplier {
                view.snp.makeConstraints { make in
                    Log.t("SNAP")
                    make.bottom.equalTo(superview)
                        //.multipliedBy(multiplier)
                }
            }
        }
    }
    
    func shouldWidthMatchParent() -> Bool {
        return matchParentWidthMultiplier != nil
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
}

public enum LayoutSize {
    case matchParent, wrapContent
}

