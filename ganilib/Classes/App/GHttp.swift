
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
        GHttp.saveCookies(response: response)
        return processHttpStatus(code: response.statusCode)
    }

    public func processHttpStatus(code _: Int) -> Bool {
        return true
    }

    public func restParams(from params: GParams, request _: HttpRequest) -> GParams {
        return params
    }

    public func restHeaders(from headers: HttpHeaders, request _: HttpRequest) -> HttpHeaders {
        return headers
    }
}

public class GHttp {
    private static let keyCookies = "__httpCookies"

    public static let instance = GHttp()

    private var buildConfig: BuildConfig!
    public private(set) var delegate: GHttpDelegate!

    public func initialize(buildConfig: BuildConfig, delegate: GHttpDelegate) {
        self.buildConfig = buildConfig
        self.delegate = delegate

        GHttp.loadCookies()
        JsonUi.register(buildConfig)
    }

    // https://stackoverflow.com/questions/35105411/saving-cookies-in-alamofire-swift
    fileprivate static func saveCookies(response: HTTPURLResponse) {
        guard let headerFields = response.allHeaderFields as? [String: String] else { return }
        guard let url = response.url else { return }

        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
        var cookieArray = [[HTTPCookiePropertyKey: Any]]()
        for cookie in cookies {
            cookieArray.append(cookie.properties!)
        }
        UserDefaults.standard.set(cookieArray, forKey: keyCookies)
        GLog.i("Saving \(cookieArray.count) cookies...")
        UserDefaults.standard.synchronize()
    }

    private static func loadCookies() {
        guard let cookieArray = UserDefaults.standard.array(forKey: keyCookies) as? [[HTTPCookiePropertyKey: Any]] else { return }

        GLog.i("Loading \(cookieArray.count) cookies...")
        for cookieProperties in cookieArray {
            if let cookie = HTTPCookie(properties: cookieProperties) {
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
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
