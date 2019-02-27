public class Device {
    public static let id = UIDevice.current.identifierForVendor!.uuidString

    // Apparently these only return the selected value if that particular language is supported by the app.
    // If not, it will fallback to the default language.
    public static let longLang = Locale.current.identifier
    public static let shortLang = Locale.current.languageCode

    public static let region = Locale.current.regionCode
    public static let os = "ios"

    public static let screenWidth = Int(UIScreen.main.bounds.width)
    public static let screenHeight = Int(UIScreen.main.bounds.height)

    public static func notchHeight() -> Float {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            return Float(window?.safeAreaInsets.bottom ?? 0)
        }
        return 0
    }
}
