import SwiftyJSON

extension JSON {
    public var iso8601: Date? {
        return Formatter.iso8601.date(from: stringValue)
    }

    public var iso8601Value: Date {
        return iso8601 ?? Date()
    }

    public var isNull: Bool {
        return type == .null
    }
}
