import os.log

// NOTE: https://stackoverflow.com/questions/9613365/exc-bad-access-on-nslog-with-no-string-formatting
open class GLog {
    public static func e(_ str: String, error: Error? = nil) {
        os_log("[ERROR] %{public}@", str)
        if let message = error?.localizedDescription {
            os_log("%{public}@", message)
        }
    }

    public static func w(_ str: String) {
        os_log("[WARN] %{public}@", str)
    }

    public static func i(_ str: String) {
        os_log("[INFO] %{public}@", str)
    }

    public static func d(_ str: String) {
        os_log("[DEBUG] %@", str)
    }

    public static func t(_ str: String) {
        d("***** \(str)")
    }
}
