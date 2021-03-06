#if INCLUDE_UILIBS

    import SwiftIconFont
    import TTTAttributedLabel
    import UIKit

    open class GAttributedLabel: TTTAttributedLabel {
        private var helper: ViewHelper!
        private var isUnderlined = false
        private var onClick: (() -> Void)?

        public override init(frame: CGRect) {
            super.init(frame: frame)
            initialize()
        }

        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            initialize()
        }

        private func initialize() {
            helper = ViewHelper(self)
        }

        public func color(_ color: UIColor) -> Self {
            textColor = color
            return self
        }

        public func color(bg: UIColor?, text: UIColor? = nil) -> Self {
            if let bgColor = bg {
                backgroundColor = bgColor
            }
            if let textColor = text {
                self.textColor = textColor
            }
            return self
        }

        public func text(_ text: String) -> Self {
            numberOfLines = 0
            self.text = text
            return self
        }

        // https://developer.apple.com/documentation/foundation/nstextcheckingtypes
        // https://developer.apple.com/documentation/foundation/nstextcheckingtype
        public func checkingTypes(_: NSTextCheckingTypes) -> Self {
//        self.enabledTextCheckingTypes = mode
            return self
        }

        // NOTE: textColor() doesn't work with SwiftIconFont and TTTAttributedLabel
//    public func icon(_ icon: String, size: CGFloat) -> Self {
//        self.numberOfLines = 0
//        self.text = icon
//        self.font = self.font.withSize(size)
//        self.parseIcon()
//        return self
//    }

        // Has to be called before text()
        public func font(_ font: UIFont) -> Self {
            self.font = font
            return self
        }

        public func font(size: Float? = nil, traits: UIFontDescriptor.SymbolicTraits...) -> Self {
            var newFont = font.withTraits(traits)
            if let newSize = size {
                newFont = newFont.withSize(CGFloat(newSize))
            }
//        if let t = traits {
//            f = f.withTraits(traits)
//        }
            return font(newFont)
//        return font(self.font.).withTraits(traits: traits))
//        return self
        }

//    public func bold() -> Self {
//        return font(self.font.bold())
//    }
//
//    public func size(w: Int?, h: Int?) -> Self {
//        helper.size(width: w, height: h)
//        return self
//    }

        public func align(_ alignment: NSTextAlignment) -> Self {
            textAlignment = alignment
            return self
        }

        // Use block instead of selector from now on. See https://stackoverflow.com/questions/24007650/selector-in-swift
        public func onClick(_ command: @escaping () -> Void) -> Self {
            onClick = command
//        addTarget(self, action: #selector(performClick), for: .touchUpInside)

            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(performClick))
            addGestureRecognizer(gestureRecognizer)
            return self
        }

        @objc private func performClick() {
            if let callback = self.onClick {
                callback()
            }
        }

        public func underline() -> Self {
            isUnderlined = true
            return self
        }

        open override func draw(_ rect: CGRect) {
            super.draw(rect)

            if isUnderlined {
                let startingPoint = CGPoint(x: rect.minX, y: rect.maxY - 2)
                let endingPoint = CGPoint(x: rect.maxX, y: rect.maxY - 2)

                let path = UIBezierPath()

                path.move(to: startingPoint)
                path.addLine(to: endingPoint)

                let traits = CTFontGetSymbolicTraits(font)
                let isBold = (traits == CTFontSymbolicTraits.traitBold)
                path.lineWidth = isBold ? 2.0 : 1.0

                textColor.setStroke()

                path.stroke()
            }
        }
    }

#endif
