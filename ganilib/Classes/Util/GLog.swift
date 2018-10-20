import os.log

// NOTE: https://stackoverflow.com/questions/9613365/exc-bad-access-on-nslog-with-no-string-formatting
open class GLog {
    static public func e(_ str: String, error: Error? = nil) {
        os_log("[ERROR] %{public}@", str)
        if let message = error?.localizedDescription {
            os_log("%{public}@", message)
        }
    }
    
    static public func w(_ str: String) {
        os_log("[WARN] %{public}@", str)
    }
    
    static public func i(_ str: String) {
        os_log("[INFO] %{public}@", str)
    }
    
    static public func d(_ str: String) {
        os_log("[DEBUG] %@", str)
    }
    
    static public func t(_ str: String) {
        d("***** \(str)")
    }
}
