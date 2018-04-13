import SwiftyJSON

extension JSON {
    public var iso8601: Date? {
        get {
            return Formatter.iso8601.date(from: stringValue)
        }
    }
    
    public var iso8601Value: Date {
        get {
            return iso8601 ?? Date()
        }
    }
}
