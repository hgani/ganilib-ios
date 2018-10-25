public class GDateFormatter: DateFormatter {
    public func format(_ format: String) -> Self {
        dateFormat = format
        return self
    }
}
