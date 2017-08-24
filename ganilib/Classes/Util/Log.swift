
// NOTE: Implement later as needed
open class Log {
    static public func i(_ str: String) {
        NSLog(str)
    }
    
    static public func d(_ str: String) {
        NSLog(str)
    }
    
    static public func t(_ str: String) {
        i("***** \(str)")
    }
}
