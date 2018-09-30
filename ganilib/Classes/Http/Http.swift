import Alamofire
import SwiftyJSON
import SVProgressHUD

public typealias GParams = [String: Any?]
public typealias HttpHeaders = [String: String]

public enum HttpMethod {
    case get
    case post
    case patch
    case delete
    case multipart
    
    public var name: String {
        return String(describing: self).uppercased()
    }
    
//    func string() -> String {
//        switch self {
//        case .get:
//            return "GET"
//        case .post:
//            return "POST"
//        case .patch:
//            return "PATCH"
//        case .delete:
//            return "DELETE"
//        case .multipart:
//            return "POST"
//        }
//    }
    
    func alamofire() -> HTTPMethod {
        switch self {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .patch:
            return HTTPMethod.patch
        case .delete:
            return HTTPMethod.delete
        case .multipart:
            return HTTPMethod.post
        }
    }
}

public class HttpRequest {
    public let method: HttpMethod
    public let url: String
    public let params: GParams
    public let headers: HttpHeaders
    public let string: String
    
    init(method: HttpMethod, url: String, params: GParams, headers: HttpHeaders) {
        self.method = method
        self.url = url
        self.params = params
        self.headers = headers
        self.string = "\(method.name) \(url)"
    }
    
    func toUrlRequest() -> URLRequest? {
        if let uri = URL(string: url) {
            var request = URLRequest(url: uri)
            request.httpMethod = method.name
            
            for (key, value) in headers {
                if key == "If-None-Match" {
                    request.cachePolicy = .reloadIgnoringLocalCacheData
                }
                request.setValue(value, forHTTPHeaderField: key)
            }
            
            switch method {
            case .post, .patch, .delete:
                request.httpBody = params.reduce("", { (result, item) -> String in
                    let key = formDataEncode(item.key)
                    let value: Any
                    if let str = item.value as? String {
                        value = formDataEncode(str)
                    }
                    else {
                        value = item.value ?? ""
                    }
                    return "\(result.isEmpty ? "" : "\(result)&")\(key)=\(value)"
                }).data(using: .ascii)
                request.setValue("application/x-www-form-urlencoded;charset=utf-8", forHTTPHeaderField: "Content-Type")
            default:
                if params.count > 0 {
                    GLog.w("Params not yet supported for this HTTP method: \(method)")
                }
            }
            
            return request
        }
        
        return nil
    }
    
    private func formDataEncode(_ string: String) -> String {
        var characters: CharacterSet = .alphanumerics
        characters.insert(charactersIn: "*-._ ")
        return string.addingPercentEncoding(withAllowedCharacters: characters)?.replacingOccurrences(of: " ", with: "+") ?? string
    }
}

public class Http {
    private let request: DataRequest
    private let actualMethod: HttpMethod
    
    init(method: HttpMethod, request: DataRequest) {
        self.actualMethod = method
        self.request = request
    }
    
    public func execute(indicator: ProgressIndicatorEnum = .standard, onHttpSuccess: @escaping (String) -> String?) {
        self.execute(indicator: indicator.delegate, onHttpSuccess: onHttpSuccess)
    }

    public func execute(indicator: ProgressIndicator, onHttpSuccess: @escaping (String) -> String?) {
        GLog.i("\(actualMethod.name) \(request.request?.url?.absoluteString ?? "")")
        
        indicator.show()
        request.responseString { response in
            if let r = response.response {
                if !GHttp.instance.delegate.processResponse(r) {
                    indicator.hide()
                    return
                }
            }
            
            switch response.result {
                case .success(let value):
                    indicator.hide()
                    if let message = onHttpSuccess(value) {
                        indicator.show(error: message)
                    }
                case .failure(let error):
                    indicator.show(error: error.localizedDescription)
            }
        }
    }
    
    private static func augmentPostParams(_ params: GParams, _ method: HttpMethod) -> GParams {
        switch method {
        case .patch, .delete:
            var mutableParams = params
            mutableParams["_method"] = method.name
            return mutableParams
        default:  // Don't augment .post to allow caller specify their own `_method`
            return params
        }
    }
    
    private static func request(_ url: String, _ method: HttpMethod, _ params: GParams, _ headers: HTTPHeaders?) -> Http {
        let augmentedParams = augmentPostParams(params, method)
        
        return Http(method: method, request: Alamofire.request(url,
            method: method.alamofire(),
            parameters: prepareParams(augmentedParams),
            headers: headers))
    }
    
    private static func prepareParams(_ params: GParams) -> [String: Any] {
        var data = [String: Any]()
        for (key, value) in params {
            if let sub = value as? GParams {
                data[key] = prepareParams(sub)
            }
            else {
                data[key] = value ?? ""
            }
        }
        return data
    }
    
    // MARK: URL-based
    
    public static func post(url: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(url, .post, params, headers)
    }
    
    public static func patch(url: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(url, .patch, params, headers)
    }
    
    public static func delete(url: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(url, .delete, params, headers)
    }
    
    public static func get(url: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(url, .get, params, headers)
    }
    
    // MARK: Path-based
    
    private static func url(from path: String) -> String {
        return "\(GHttp.instance.host())\(path)"
    }
    
    public static func post(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return post(url: url(from: path), params: params, headers: headers)
    }
    
    public static func patch(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return patch(url: url(from: path), params: params, headers: headers)
    }
    
    public static func delete(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return delete(url: url(from: path), params: params, headers: headers)
    }
    
    public static func get(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return get(url: url(from: path), params: params, headers: headers)
    }
}
