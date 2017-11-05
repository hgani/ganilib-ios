
import Foundation

// NOTE: Deprecated. Use SelectOption instead
//open class LabelValuePair<T> : NSObject {
//    public let label : String
//    public let value : T
//
//    public init(_ label : String, _ value : T) {
//        self.label = label
//        self.value = value
//    }
//
//    open override var description: String {
//        return label
//    }
//}

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
