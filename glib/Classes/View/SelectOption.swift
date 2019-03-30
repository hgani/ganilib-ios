import Foundation

open class SelectOption<T>: NSObject {
    public let label: String
    public let value: T
    public let color: UIColor?

    public init(label: String, value: T, color: UIColor? = nil) {
        self.label = label
        self.value = value
        self.color = color
    }

    open override var description: String {
        return label
    }
}
