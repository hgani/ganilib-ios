import UIKit

open class GSwitch: UISwitch {
    private var helper: ViewHelper!
    private var onClick: (() -> Void)?

    public init() {
        super.init(frame: .zero)

        helper = ViewHelper(self)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func width(_ width: Int) -> Self {
        helper.width(width)
        return self
    }

    public func height(_ height: Int) -> Self {
        helper.height(height)
        return self
    }

    public func color(bg: UIColor?, text _: UIColor? = nil) -> Self {
        if let bgColor = bg {
            backgroundColor = bgColor
        }
        return self
    }

    public func end() {
        // End chaining initialisation
    }
}
