//
//import UIKit
//
//open class GHorizontalHamburger: UIView, GContainer {
//    private var helper: ViewHelper!
//
//    public init() {
//        super.init(frame: .zero)
//        initialize()
//    }
//
//    required public init?(coder: NSCoder) {
//        super.init(coder: coder)
//        initialize()
//    }
//
//    private func initialize() {
//        self.helper = ViewHelper(self)
//
//        _ = paddings(t: 0, l: 0, b: 0, r: 0)
//    }
//
//    public func withViews(_ first: UIView, _ middle: UIView, _ last: UIView) -> Self {
//        // The hope is this makes things more predictable
//        first.translatesAutoresizingMaskIntoConstraints = false
//        middle.translatesAutoresizingMaskIntoConstraints = false
//        last.translatesAutoresizingMaskIntoConstraints = false
////
//        addSubview(first)
//        addSubview(middle)
//        addSubview(last)
//
//        first.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.topMargin)
//            make.left.equalTo(self.snp.leftMargin)
//        }
//
//        middle.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.topMargin)
//
//            make.left.equalTo(first.snp.right)
//            make.right.equalTo(last.snp.left)
//
//        }
//
//        last.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.topMargin)
//            make.right.equalTo(self.snp.rightMargin)
//        }
////
////        self.snp.makeConstraints { make in
////            make.rightMargin.greaterThanOrEqualTo(first.snp.right)
////            make.rightMargin.greaterThanOrEqualTo(middle.snp.right)
////            make.rightMargin.greaterThanOrEqualTo(last.snp.right)
////        }
//
//        self.snp.makeConstraints { make in
//            make.bottomMargin.greaterThanOrEqualTo(first.snp.bottom)
//            make.bottomMargin.greaterThanOrEqualTo(middle.snp.bottom)
//            make.bottomMargin.greaterThanOrEqualTo(last.snp.bottom)
//        }
//        return self
//    }
//
//    public func color(bg: UIColor) -> Self {
//        self.backgroundColor = bg
//        return self
//    }
//
//    public func paddings(t top: CGFloat? = nil, l left: CGFloat? = nil, b bottom: CGFloat? = nil, r right: CGFloat? = nil) -> Self {
//        helper.paddings(t: top, l: left, b: bottom, r: right)
//        return self
//    }
//}

