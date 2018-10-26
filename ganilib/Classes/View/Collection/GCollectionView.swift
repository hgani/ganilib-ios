
import UIKit

open class GCollectionView: UICollectionView {
    private var helper: ViewHelper!

    fileprivate var pager: UIPageControl?

    //    private let pageControl: UIPageControl = {
    //        let pc = UIPageControl()
    //        pc.currentPage = 0
    //        pc.numberOfPages = 3
    //        pc.currentPageIndicatorTintColor = .darkGray
    //        pc.pageIndicatorTintColor = .lightGray
    //        return pc
    //    }()

    public init() {
        super.init(frame: .zero, collectionViewLayout: GCollectionViewFlowLayout())
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)
        delegate = self
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

    public func width(weight: Float, offset: Float = 0) -> Self {
        helper.width(weight: weight, offset: offset)
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

    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        return self
    }

    public func layout(_ layout: GCollectionViewFlowLayout) -> Self {
        collectionViewLayout = layout
        return self
    }

    public func pagingEnabled(_ enabled: Bool) -> Self {
        isPagingEnabled = enabled
        return self
    }

    public func scrollIndicator(horizontal: Bool) -> Self {
        showsHorizontalScrollIndicator = horizontal
        return self
    }

    public func scrollIndicator(vertical: Bool) -> Self {
        showsVerticalScrollIndicator = vertical
        return self
    }

    public func source(_ source: UICollectionViewDataSource) -> Self {
        dataSource = source
        return self
    }

    public func pager(_ pager: UIPageControl) -> Self {
        self.pager = pager
        return self
    }

    public func register(cellType: GCollectionViewCell.Type) -> Self {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier())
        return self
    }

    public func cellInstance<T: GCollectionViewCell>(of type: T.Type, for indexPath: IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier(), for: indexPath) as? T {
            return cell
        }
        return type.init()
    }

    public func done() {
        // End chaining
    }
}

public class GCollectionViewFlowLayout: UICollectionViewFlowLayout {
    public func horizontal() -> Self {
        scrollDirection = .horizontal
        return self
    }
}

extension GCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }

    public func scrollViewWillEndDragging(_: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = targetContentOffset.pointee.x / frame.width
        pager?.currentPage = Int(currentPage)
    }

    public func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}

open class GCollectionViewCell: UICollectionViewCell {
    private let container = GVerticalPanel()

//    public required init() {
//        super.init(frame: .zero)
//        initialize()
//    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        contentView.addSubview(container)
        initContent()
    }

    open func initContent() {
        // To be overridden
    }

    open override func didMoveToSuperview() {
        container.snp.makeConstraints { (make) -> Void in
            // See GTableViewCustomCell
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom)

            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
        }
    }

    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        _ = container.paddings(top: top, left: left, bottom: bottom, right: right)
        return self
    }

    public func addView(_ view: UIView, top: CGFloat? = nil) {
        container.addView(view, top: top)
    }

    public func append(_ view: UIView, top: CGFloat? = nil) -> Self {
        container.addView(view, top: top)
        return self
    }

    public func color(bg: UIColor) -> Self {
        contentView.backgroundColor = bg
        return self
    }

    public func done() {
        // End call chaining
    }

    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
