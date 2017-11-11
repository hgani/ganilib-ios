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
        Log.i("Request canceled: \(string)")
        self.canceled = true
        
        if let r = self.request {
            r.cancel()
        }
        
        // TODO: Consider setting request to nil so that the listener (including all its references) can be garbage collected
    }
    
    private func executeGeneric(indicator: ProgressIndicator, onHttpSuccess: @escaping (Json) -> Bool) {
        Log.i(string)
        
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
                    Log.d("Result: \(json)")
                    if !onHttpSuccess(json) {
                        indicator.show(error: json["message"].stringValue)
                    }
                case .failure(let error):
                    indicator.show(error: error.localizedDescription)
                }
            }
        }
    }
    
    public func execute(indicator: ProgressIndicator = StandardProgressIndicator.shared, onHttpSuccess: @escaping (Json) -> Bool) -> Self {
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
                        let percentage = (progress.fractionCompleted * 100).rounded()
                        indicator.show(success: "Uploading (\(percentage)%)")
                    }
                    
                    self.request = upload
                    self.executeGeneric(indicator: indicator, onHttpSuccess: onHttpSuccess)
                }
            })
        default:
            self.request = Alamofire.request(url, method: method.alamofire(), parameters: params, headers: headers)
            executeGeneric(indicator: indicator, onHttpSuccess: onHttpSuccess)
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
        let url = "\(GHttp.instance.host())\(path)"
        let augmentedParams = augmentPostParams(params, method)
        let preparedParams = prepareParams(GHttp.instance.delegate.restParams(from: augmentedParams, method: method))
        return Rest(method: method, url: url, params: preparedParams, headers: headers)
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
    
    public static func multipart(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Rest {
        return request(path, .multipart, params, headers)
    }
}
