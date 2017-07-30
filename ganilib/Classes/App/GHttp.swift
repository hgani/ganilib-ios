
import UIKit

public class GHttp {
    static public let instance = GHttp()
    
    private var buildConfig: BuildConfig!
    
    public func initialize(_ buildConfig: BuildConfig) -> Self {
        self.buildConfig = buildConfig
        return self
    }
    
    public func host() -> String {
        assert(buildConfig != nil, "Call GHttp.instance.initialize() in AppDelegate first")
        return buildConfig.host()
    }
    
    public func hostUrl() -> URL {
        return URL(string: host())!
    }
}

