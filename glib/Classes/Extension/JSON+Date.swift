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

    public var presence: JSON? {
        // Not sure why ternary operator doesn't work in this case
        if isNull {
            return nil
        }
        return self
    }
}
