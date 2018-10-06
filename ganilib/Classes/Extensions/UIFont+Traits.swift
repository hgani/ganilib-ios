import UIKit

public extension UIFont {
    func withTraits(_ traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
        return withTraits(traits)
    }

    func withTraits(_ traits: [UIFontDescriptorSymbolicTraits]) -> UIFont {
        if let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits)) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        return self
    }

    func bold() -> UIFont {
        return withTraits(.traitBold)
    }

    func italic() -> UIFont {
        return withTraits(.traitItalic)
    }
    
    func boldItalic() -> UIFont {
        return withTraits(.traitBold, .traitItalic)
    }
}
