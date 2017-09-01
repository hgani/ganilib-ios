import Alamofire
import SwiftyJSON
import SVProgressHUD

public typealias GParams = [String: Any?]
//public typealias HttpMethod = HTTPMethod

public enum HttpMethod {
    case get
    case post
    case patch
    case delete
    
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
        }
    }
}

public class Rest {
    private let request: DataRequest
    
    init(_ request: DataRequest) {
        self.request = request
    }
    
    public func execute(indicator: ProgressIndicator = StandardProgressIndicator.shared, onHttpSuccess: @escaping (JSON) -> Bool) {
        Log.i("\(request.request?.httpMethod ?? "") \(request.request?.url?.absoluteString ?? "")")
        
//        SVProgressHUD.show()
        indicator.showProgress()
        request.responseString { response in
            switch response.result {
                case .success(let value):
//                    SVProgressHUD.dismiss()
                    indicator.hideProgress()
                    
                    let json = JSON(parseJSON: value)
                    Log.d("Result: \(json)")
                    if !onHttpSuccess(json) {
//                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                        indicator.showError(message: json["message"].stringValue)
                    }
                case .failure(let error):
//                    SVProgressHUD.showError(withStatus: error.localizedDescription)
                    indicator.showError(message: error.localizedDescription)
            }
        }
    }
    
    private static func request(_ path: String, _ method: HttpMethod, _ params: GParams, _ headers: HTTPHeaders?) -> Rest {
        return Rest(Alamofire.request("\(GHttp.instance.host())\(path)",
            method: method.alamofire(),
            parameters: prepareParams(GHttp.instance.delegate.restParams(from: params, method: method)),
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
    
    public static func get(path: String, params: GParams = GParams(), headers: HTTPHeaders? = nil) -> Rest {
        return request(path, .get, params, headers)
    }
}
