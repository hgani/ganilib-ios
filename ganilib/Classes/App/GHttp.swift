
import Alamofire

public protocol GHttpDelegate {
    // Parameters is a Dictionary which is a struct so the delegate can safely modify it.
    func restParams(from params: GParams, method: HttpMethod) -> GParams
}

public class GHttp {
    static public let instance = GHttp()
    
    private var buildConfig: BuildConfig!
    private(set) var delegate: GHttpDelegate!
    
    public func initialize(buildConfig: BuildConfig, delegate: GHttpDelegate) {
        self.buildConfig = buildConfig
        self.delegate = delegate
    }
    
    public func host() -> String {
        assert(buildConfig != nil, "Call GHttp.instance.initialize() in AppDelegate first")
        return buildConfig.host()
    }
    
    public func hostUrl() -> URL {
        return URL(string: host())!
    }
}

