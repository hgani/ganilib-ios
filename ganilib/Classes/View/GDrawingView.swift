// From https://github.com/maximbilan/ios_swift_drawing_app
open class GDrawingView: UIView {
    var drawColor = UIColor.black
    var lineWidth: CGFloat = 5

    private var lastPoint: CGPoint!
    private var bezierPath: UIBezierPath!
    private var pointCounter: Int = 0
    private let pointLimit: Int = 128
    private var preRenderImage: UIImage?

    private var helper: ViewHelper!
    public var image: UIImage? {
        return preRenderImage
    }

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    private func initialize() {
        helper = ViewHelper(self)

        bezierPath = UIBezierPath()
        bezierPath.lineCapStyle = CGLineCap.round
        bezierPath.lineJoinStyle = CGLineJoin.round
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

    // MARK: - Touch handling

    open override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        let touch: AnyObject? = touches.first
        lastPoint = touch!.location(in: self)
        pointCounter = 0
    }

    open override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        let touch: AnyObject? = touches.first
        let newPoint = touch!.location(in: self)

        bezierPath.move(to: lastPoint)
        bezierPath.addLine(to: newPoint)
        lastPoint = newPoint

        pointCounter += 1

        if pointCounter == pointLimit {
            pointCounter = 0
            renderToImage()
            setNeedsDisplay()
            bezierPath.removeAllPoints()
        } else {
            setNeedsDisplay()
        }
    }

    open override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        pointCounter = 0
        renderToImage()
        setNeedsDisplay()
        bezierPath.removeAllPoints()
    }

    open override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        touchesEnded(touches!, with: event)
    }

    // MARK: - Pre render

    func renderToImage() {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        if let img = preRenderImage {
            img.draw(in: bounds)
        }

        bezierPath.lineWidth = lineWidth
        drawColor.setFill()
        drawColor.setStroke()
        bezierPath.stroke()

        preRenderImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
    }

    // MARK: - Render

    open override func draw(_ rect: CGRect) {
        super.draw(rect)

        if let img = preRenderImage {
            img.draw(in: bounds)
        }

        bezierPath.lineWidth = lineWidth
        drawColor.setFill()
        drawColor.setStroke()
        bezierPath.stroke()
    }

    // MARK: - Clearing

    func clear() {
        preRenderImage = nil
        bezierPath.removeAllPoints()
        setNeedsDisplay()
    }

    // MARK: - Other

    func hasLines() -> Bool {
        return preRenderImage != nil || !bezierPath.isEmpty
    }
}
