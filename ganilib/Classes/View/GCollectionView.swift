
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

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    private func initialize() {
        self.helper = ViewHelper(self)
        self.delegate = self
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
            self.backgroundColor = bgColor
        }
        return self
    }
    
    public func layout(_ layout: GCollectionViewFlowLayout) -> Self {
        self.collectionViewLayout = layout
        return self
    }
    
    public func pagingEnabled(_ enabled: Bool) -> Self {
        self.isPagingEnabled = enabled
        return self
    }
    
    public func scrollIndicator(horizontal: Bool) -> Self {
        self.showsHorizontalScrollIndicator = horizontal
        return self
    }
    
    public func scrollIndicator(vertical: Bool) -> Self {
        self.showsVerticalScrollIndicator = vertical
        return self
    }

    public func source(_ source: UICollectionViewDataSource) -> Self {
        self.dataSource = source
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
        self.scrollDirection = .horizontal
        return self
    }
}



extension GCollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = targetContentOffset.pointee.x / self.frame.width
        pager?.currentPage = Int(currentPage)
    }
}



open class GCollectionViewCell: UICollectionViewCell {
    private let container = GVerticalPanel()
    
    public required init() {
        super.init(frame: .zero)
        internalInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        internalInit()
    }
    
    private func internalInit() {
        self.contentView.addSubview(container)
        initialize()
    }

    open func initialize() {
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
        _ = container.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }
    
    public func addView(_ view: UIView, top : CGFloat? = nil) {
        container.addView(view, top: top)
    }
    
    public func append(_ view: UIView, top : CGFloat? = nil) -> Self {
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
