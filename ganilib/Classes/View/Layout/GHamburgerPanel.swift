
import UIKit

open class GHamburgerPanel: UIView, IContainer {
    private var helper: ViewHelper!

    public var size: CGSize {
        return helper.size
    }

    public init() {
        super.init(frame: .zero)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)

        _ = paddings(t: 0, l: 0, b: 0, r: 0)
    }

//    public init() {
//        super.init(frame: .zero)
//
//        self.helper = ViewHelper(self)
//
//        self.translatesAutoresizingMaskIntoConstraints = false
//
    ////
    ////        addSubview(headerView)
    ////        addSubview(contentView)
    ////        addSubview(footerView)
    ////
    ////                headerView.snp.makeConstraints { make in
    ////                    make.centerX.equalTo(self)
    ////                    make.width.equalTo(self)
    ////
    ////                    make.top.equalTo(self)
    //////                    make.bottom.equalTo(self)
    ////                }
    ////
    ////        headerView.snp.makeConstraints { make in
    ////            make.centerX.equalTo(self)
    ////            make.width.equalTo(self)
    ////
    ////            make.top.equalTo(self)
    ////            //                    make.bottom.equalTo(self)
    ////        }
//
    ////        // See https://github.com/zaxonus/AutoLayScroll
    ////        self.translatesAutoresizingMaskIntoConstraints = false
    ////        contentView.translatesAutoresizingMaskIntoConstraints = false
    ////
    ////        self.backgroundColor = .green
    ////        contentView.backgroundColor = .red
    ////
    ////        self.addSubview(contentView)
    ////        contentView.snp.makeConstraints { make in
    ////            make.centerX.equalTo(self)
    ////            make.width.equalTo(self)
    ////
    ////            make.top.equalTo(self)
    ////            make.bottom.equalTo(self)
    ////        }
//    }
//
//    public required init?(coder aDecoder: NSCoder) {
//        fatalError("Not supported")
//    }

    public func withViews(_ top: UIView, _ middle: UIView, _ bottom: UIView) -> Self {
        // The hope is this makes things more predictable
        top.translatesAutoresizingMaskIntoConstraints = false
        middle.translatesAutoresizingMaskIntoConstraints = false
        bottom.translatesAutoresizingMaskIntoConstraints = false

        addSubview(top)
        addSubview(middle)
        addSubview(bottom)

        top.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)
            make.top.equalTo(self.snp.topMargin)
//                .offset(paddings.top)
//                .offset(paddings.left)

//            make.height.greaterThanOrEqualTo(0)
        }

//        middle.snp.contentHuggingVerticalPriority = 1000

        middle.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)

            make.top.equalTo(top.snp.bottom)
            make.bottom.equalTo(bottom.snp.top)
        }
        bottom.snp.makeConstraints { make in
            make.left.equalTo(self.snp.leftMargin)
            make.bottom.equalTo(self.snp.bottomMargin)
//                .offset(paddings.top)
        }

        //        DispatchQueue.main.async {
        snp.makeConstraints { make in
            make.rightMargin.greaterThanOrEqualTo(top.snp.right)
//                .offset(self.paddings.bottom)
            make.rightMargin.greaterThanOrEqualTo(middle.snp.right)
            make.rightMargin.greaterThanOrEqualTo(bottom.snp.right)
//                .offset(self.paddings.bottom)
        }
        return self
    }

    public func color(bg: UIColor) -> Self {
        backgroundColor = bg
        return self
    }

    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        helper.didMoveToSuperview()
    }

    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }

    public func width(_ width: LayoutSize) -> Self {
        helper.width(width)
        return self
    }

    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }

    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
}
