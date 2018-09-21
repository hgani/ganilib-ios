import Alamofire
import SwiftyJSON
import SVProgressHUD

public typealias Json = JSON
typealias NonNullParams = [String: Any]

public class Rest {
    private let method: HttpMethod
    private let url: String
    private let params: NonNullParams
    private let headers: HTTPHeaders?
    private let string: String
    
    private var request: DataRequest?
    private var canceled: Bool
    
    init(method: HttpMethod, url: String, params: NonNullParams, headers: HTTPHeaders?) {
        self.method = method
        self.url = url
        self.params = params
        self.headers = headers
        
        self.string = "\(method.alamofire().rawValue) \(url)"
        self.canceled = false
    }
    
    public func cancel() {
        GLog.i("Request canceled: \(string)")
        self.canceled = true
        
        if let r = self.request {
            r.cancel()
        }
    }
    
    private func executeGeneric(indicator: ProgressIndicator,
                                onHttpSuccess: @escaping (Json) -> Bool,
                                onHttpFailure: @escaping (Error) -> Bool) {
        GLog.i(string)
        #if DEBUG || ADHOC
            GLog.i("Params: \(params)")
        #endif
        
        indicator.show()
        if let r = request {
            r.responseString { response in
                if let r = response.response {
                    if !GHttp.instance.delegate.processResponse(r) {
                        indicator.hide()
                        return
                    }
                }
                
                switch response.result {
                case .success(let value):
                    indicator.hide()
                    
                    let json = JSON(parseJSON: value)
                    var status = "Unknown status"
                    if let code = response.response?.statusCode {
                        status = String(code)
                    }
                    GLog.d("[\(status)]: \(json)")
                    if !onHttpSuccess(json) {
                        indicator.show(error: json["message"].string ?? json["error"].string ?? "")
                    }
                case .failure(let error):
                    if !onHttpFailure(error) {
                        indicator.show(error: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    public func execute(indicator: ProgressIndicatorEnum = .standard,
                        onHttpFailure: @escaping (Error) -> Bool = { _ in return false },
                        onHttpSuccess: @escaping (Json) -> Bool) -> Self {
        return self.execute(indicator: indicator.delegate, onHttpFailure: onHttpFailure, onHttpSuccess: onHttpSuccess)
    }
    
    // (16 Nov 2017) We've tested using CFGetRetainCount() and deinit() to make sure that onHttpSuccess doesn't linger
    // after the request finishes. This is true even in the case where the request object (i.e. Rest) is assigned to an
    // instance variable, so it is safe to pass a closure that accesses `self` without `unowned`.
    public func execute(indicator: ProgressIndicator,
                        onHttpFailure: @escaping (Error) -> Bool = { _ in return false },
                        onHttpSuccess: @escaping (Json) -> Bool) -> Self {
        if canceled {
            return self
        }
        
        switch method {
        case .multipart:
            Alamofire.upload(multipartFormData: { (formData) in
                for (key, value) in self.params {
                    if value is UIImage {
                        formData.append(UIImageJPEGRepresentation((value as! UIImage), 1)!,
                                        withName: key,
                                        fileName: "images.jpeg",
                                        mimeType: "image/jpeg")
                    }
                    else {
                        formData.append(String(describing: value).data(using: .utf8)!, withName: key)
                    }
                }
            }, usingThreshold: 0,
               to: self.url,
               method: HTTPMethod.post,
               headers: self.headers,
               encodingCompletion: { (result) in
                switch result {
                case .failure(let error):
                    indicator.show(error: error.localizedDescription)
                case .success(let upload, _, _):
                    upload.uploadProgress { progress in
                        // Subtract because it's potentially confusing to the user when we are at 100% for a few seconds.
                        let fraction = progress.fractionCompleted - 0.02
                        let percentage = (fraction * 100).rounded()
                        GLog.t("Uploading (\(percentage)%) -- \(fraction)")
                        indicator.show(progress: Float(fraction))
                    }
                    
                    self.request = upload
                    self.executeGeneric(indicator: indicator, onHttpSuccess: onHttpSuccess, onHttpFailure: onHttpFailure)
                }
            })
        default:
            self.request = Alamofire.request(url, method: method.alamofire(), parameters: params, headers: headers)
            executeGeneric(indicator: indicator, onHttpSuccess: onHttpSuccess, onHttpFailure: onHttpFailure)
        }
        return self
    }
    
    public func done() {
        // End chaining
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
    
    private static func request(_ url: String, _ method: HttpMethod, _ params: GParams, _ headers: HttpHeaders) -> Rest {
        let augmentedParams = augmentPostParams(params, method)
        let request = HttpRequest(method: method, url: url, params: params, headers: headers)
        
        let restParams: NonNullParams, restHeaders: HttpHeaders
        if url.starts(with: GHttp.instance.host()) {
            restParams  = prepareParams(GHttp.instance.delegate.restParams(from: augmentedParams, request: request))
            restHeaders  = GHttp.instance.delegate.restHeaders(from: headers, request: request)
        }
        else {
            restParams = prepareParams(augmentedParams)
            restHeaders = headers
        }
        
        return Rest(method: method, url: url, params: restParams, headers: restHeaders)
    }
    
    private static func prepareParams(_ params: GParams) -> NonNullParams {
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
    
    public static func post(url: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return request(url, .post, params, headers)
    }
    
    public static func patch(url: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return request(url, .patch, params, headers)
    }
    
    public static func delete(url: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return request(url, .delete, params, headers)
    }
    
    public static func get(url: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return request(url, .get, params, headers)
    }
    
    public static func multipart(url: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return request(url, .multipart, params, headers)
    }
    
    // MARK: Path-based
    
    private static func url(from path: String) -> String {
        return "\(GHttp.instance.host())\(path)"
    }
    
    public static func post(path: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return post(url: url(from: path), params: params, headers: headers)
    }
    
    public static func patch(path: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return patch(url: url(from: path), params: params, headers: headers)
    }
    
    public static func delete(path: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return delete(url: url(from: path), params: params, headers: headers)
    }
    
    public static func get(path: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return get(url: url(from: path), params: params, headers: headers)
    }
    
    public static func multipart(path: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest {
        return multipart(url: url(from: path), params: params, headers: headers)
    }
    
    public static func from(method: String, url: String, params: GParams = GParams(), headers: HttpHeaders = HttpHeaders()) -> Rest? {
        switch method {
        case "post":
            return post(url: url, params: params, headers: headers)
        case "patch":
            return patch(url: url, params: params, headers: headers)
        case "delete":
            return delete(url: url, params: params, headers: headers)
        case "get":
            return get(url: url, params: params, headers: headers)
        case "multipart":
            return multipart(url: url, params: params, headers: headers)
        default:
            return nil
        }
    }
}
