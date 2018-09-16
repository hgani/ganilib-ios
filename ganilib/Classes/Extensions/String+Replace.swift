import Foundation

public extension String {
    public func replace(regex: String, with replacement: String) -> String {
        if let regex = try? NSRegularExpression(pattern: regex) {
            let value = NSMutableString(string: self)
            regex.replaceMatches(in: value, options: .reportProgress, range: NSRange(location: 0, length: self.count), withTemplate: replacement)
            return String(describing: value)
        }
        return self
    }
}
