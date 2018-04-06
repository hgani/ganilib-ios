
import Alamofire

public protocol GHttpDelegate {
    // Parameters is a Dictionary which is a struct so the delegate can safely modify it.
    func restParams(from params: GParams, request: HttpRequest) -> GParams
    func restHeaders(from headers: HttpHeaders, request: HttpRequest) -> HttpHeaders
    
    func processResponse(_ response: HTTPURLResponse) -> Bool
    func processHttpStatus(code: Int) -> Bool
}

extension GHttpDelegate {
    public func processResponse(_ response: HTTPURLResponse) -> Bool {
        return processHttpStatus(code: response.statusCode)
    }
    
    public func processHttpStatus(code: Int) -> Bool {
        return true
    }
    
    public func restParams(from params: GParams, request: HttpRequest) -> GParams {
        return params
    }
    
    public func restHeaders(from headers: HttpHeaders, request: HttpRequest) -> HttpHeaders {
        return headers
    }
}

public class GHttp {
    static public let instance = GHttp()
    
    private var buildConfig: BuildConfig!
    public private(set) var delegate: GHttpDelegate!
    
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
    
    public func clearCookies() {
        let cstorage = HTTPCookieStorage.shared
        if let cookies = cstorage.cookies(for: GHttp.instance.hostUrl()) {
            for cookie in cookies {
                cstorage.deleteCookie(cookie)
            }
        }
    }
}

