import Alamofire
import SwiftyJSON
import SVProgressHUD

public typealias GParams = [String: Any?]

public class Rest {
    private let request: DataRequest
    
    init(_ request: DataRequest) {
        self.request = request
    }
    
    public func execute(onHttpSuccess: @escaping (JSON) -> Bool) {
        Log.i("\(request.request?.httpMethod ?? "") \(request.request?.url?.absoluteString ?? "")")
        
        SVProgressHUD.show()
        request.responseString { response in
            switch response.result {
                case .success(let value):
                    SVProgressHUD.dismiss()
                    let json = JSON(parseJSON: value)
                    Log.d("Result: \(json)")
                    if !onHttpSuccess(json) {
                        SVProgressHUD.showError(withStatus: json["message"].stringValue)
                    }
                case .failure(let error):
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    private static func request(_ path: String, _ method: HTTPMethod, _ params: GParams) -> Rest {
        return Rest(Alamofire.request("\(GHttp.instance.host())\(path)",
            method: method,
            parameters: prepareParams(GHttp.instance.delegate.restParams(params))))
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
    
    public static func post(path: String, params: GParams = GParams()) -> Rest {
        return request(path, .post, params)
    }
    
    public static func get(path: String, params: GParams = GParams()) -> Rest {
        return request(path, .get, params)
    }
}

