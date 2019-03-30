import SwiftIconFont

public struct GIcon {
    let font: Fonts
    let code: String

    public init(font: Fonts, code: String) {
        self.font = font
        self.code = code
    }

    private var prefix: String {
        switch font {
        case .fontAwesome:
            return "fa"
        case .iconic:
            return "ic"
        case .ionicon:
            return "io"
        case .mapIcon:
            return "mi"
        case .materialIcon:
            return "ma"
        case .octicon:
            return "oc"
        case .segoeMDL2:
            return "sm"
        case .themify:
            return "ti"
        }
    }

    var string: String {
        return "\(prefix):\(code)"
    }
}
