import Alamofire
import SwiftyJSON
import SVProgressHUD

public typealias GParams = [String: Any?]

public enum HttpMethod {
    case get
    case post
    case patch
    case delete
    case multipart
    
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

public class Http {
    private let request: DataRequest
    private let actualMethod: HttpMethod
    
    init(method: HttpMethod, request: DataRequest) {
        self.actualMethod = method
        self.request = request
    }
    
    public func execute(indicator: ProgressIndicator = StandardProgressIndicator.shared, onHttpSuccess: @escaping (String) -> String?) {
        Log.i("\(actualMethod.alamofire().rawValue) \(request.request?.url?.absoluteString ?? "")")
        
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
            mutableParams["_method"] = method.alamofire().rawValue
            return mutableParams
        default:  // Don't augment .post to allow caller specify their own `_method`
            return params
        }
    }
    
    private static func request(_ path: String, _ method: HttpMethod, _ params: GParams, _ headers: HTTPHeaders?) -> Http {
        let augmentedParams = augmentPostParams(params, method)
        
        return Http(method: method, request: Alamofire.request("\(GHttp.instance.host())\(path)",
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
    
    public static func post(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(path, .post, params, headers)
    }
    
    public static func patch(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(path, .patch, params, headers)
    }
    
    public static func delete(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(path, .delete, params, headers)
    }
    
    public static func get(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Http {
        return request(path, .get, params, headers)
    }
}
