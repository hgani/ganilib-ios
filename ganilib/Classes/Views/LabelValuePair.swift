
import Foundation

open class LabelValuePair<T> : NSObject {
    public let label : String
    public let value : T
    
    public init(_ label : String, _ value : T) {
        self.label = label
        self.value = value
    }
    
    open override var description: String {
        return label
    }
}
