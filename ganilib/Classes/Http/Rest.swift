import Alamofire
import SwiftyJSON
import SVProgressHUD

public typealias Json = JSON

public class Rest {
    private let request: DataRequest
    private let actualMethod: HttpMethod
    
    init(method: HttpMethod, request: DataRequest) {
        self.actualMethod = method
        self.request = request
    }
    
    public func cancel() {
        self.request.cancel()
    }
    
    public func execute(indicator: ProgressIndicator = StandardProgressIndicator.shared, onHttpSuccess: @escaping (Json) -> Bool) -> Self {
        Log.i("\(actualMethod.alamofire().rawValue) \(request.request?.url?.absoluteString ?? "")")
        
        indicator.showProgress()
        request.responseString { response in
            if let r = response.response {
                if !GHttp.instance.delegate.processResponse(r) {
                    indicator.hideProgress()
                    return
                }
            }
            
            switch response.result {
                case .success(let value):
                    indicator.hideProgress()
                    
                    let json = JSON(parseJSON: value)
                    Log.d("Result: \(json)")
                    if !onHttpSuccess(json) {
                        indicator.showError(message: json["message"].stringValue)
                    }
                case .failure(let error):
                    indicator.showError(message: error.localizedDescription)
            }
        }
        
        return self
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
    
    private static func request(_ path: String, _ method: HttpMethod, _ params: GParams, _ headers: HTTPHeaders?) -> Rest {
        let augmentedParams = augmentPostParams(params, method)
        
        return Rest(method: method, request: Alamofire.request("\(GHttp.instance.host())\(path)",
            method: method.alamofire(),
            parameters: prepareParams(GHttp.instance.delegate.restParams(from: augmentedParams, method: method)),
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
    
    public static func post(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Rest {
        return request(path, .post, params, headers)
    }
    
    public static func patch(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Rest {
        return request(path, .patch, params, headers)
    }
    
    public static func delete(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Rest {
        return request(path, .delete, params, headers)
    }
    
    public static func get(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Rest {
        return request(path, .get, params, headers)
    }
}
