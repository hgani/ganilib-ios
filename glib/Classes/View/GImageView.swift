import UIKit

open class GImageView: UIImageView {
    private var helper: ViewHelper!
    private var event: EventHelper<GImageView>!

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
        event = EventHelper(self)
    }

    // Needed for helper.width() and helper.height()
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

    @discardableResult
    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    @discardableResult
    public func height(_ height: LayoutSize) -> Self {
        helper.height(height)
        return self
    }

    @discardableResult
    public func color(bg: UIColor?) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        return self
    }

    @discardableResult
    public func source(name: String) -> Self {
        return source(image: UIImage(named: name))
    }

    @discardableResult
    public func source(image: UIImage?) -> Self {
        self.image = image
        return self
    }

    public func border(color: UIColor?, width: Float = 1, corner: Float = 6) -> Self {
        helper.border(color: color, width: width, corner: corner)
        return self
    }

    public func paddings(t top: Float? = nil, l left: Float? = nil, b bottom: Float? = nil, r right: Float? = nil) -> Self {
        helper.paddings(t: top, l: left, b: bottom, r: right)
        return self
    }

    open func onClick(_ command: @escaping (GImageView) -> Void) -> Self {
        event.onClick(command)
        return self
    }

    public func adjustHeight() {
        if let safeImage = image {
            layoutIfNeeded()

            let ratio = safeImage.size.width / safeImage.size.height
            let height = frame.width / ratio

            NSLog("Adjusting to height: \(height)")

            snp.makeConstraints { (make) -> Void in
                make.height.equalTo(height)
            }
        }
    }

    public func contentMode(_ mode: UIViewContentMode) -> Self {
        contentMode = mode
        return self
    }

    public func done() {
        // End chaining
    }
}

#if INCLUDE_KINGFISHER

    import Kingfisher

    extension GImageView {
        @discardableResult
        public func source(url: URL?, placeholder: UIImage? = nil) -> Self {
            kf.setImage(with: url, placeholder: placeholder)
            return self
        }

        @discardableResult
        public func source(url: String, placeholder: UIImage? = nil) -> Self {
            return source(url: URL(string: url), placeholder: placeholder)
        }
    }

#endif
