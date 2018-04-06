
public class Device {
    public static let id = UIDevice.current.identifierForVendor!.uuidString
    
    public static let longLang = Locale.current.identifier
    public static let shortLang = Locale.current.languageCode
}

