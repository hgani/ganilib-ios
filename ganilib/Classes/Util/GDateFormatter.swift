public class GDateFormatter: DateFormatter {
    public func format(_ format: String) -> Self {
        self.dateFormat = format
        return self
    }
}
