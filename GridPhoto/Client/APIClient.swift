import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class APIClient {
    
    static let shared = { APIClient(baseURL: Manager.shared.APIURL) }()
    
    var baseURL: URL?
    
    required init(baseURL: String) {
        self.baseURL = URL(string: baseURL)
    }
    
    func getArray<T: BaseMappable>(_ urlString: String, parameters: Parameters? = nil, success: @escaping (Int, [T]) -> (), failure: @escaping (Int) -> ()) {
        
        var headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let APIKey = Manager.shared.APIKey
        
        headers["Authorization"] = "Client-ID \(APIKey)"
        
        let URL = NSURL(string: urlString, relativeTo: self.baseURL)
        let urlString = URL?.absoluteURL!
        
        Alamofire.request(urlString!, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseArray { (response: DataResponse<[T]>) in
                
                if (response.response != nil && response.result.value != nil && (response.response?.statusCode == 200 || response.response?.statusCode == 201)) {
                    debugPrint("Response - ", response.result.value!.toJSONString() ?? "")
                    success(response.response!.statusCode, response.result.value!)
                } else if (response.response?.statusCode == 401) {
                    debugPrint("Not authorized: \(String(describing: response.response?.statusCode))")
                } else {
                    debugPrint("Error: \(String(describing: response.response?.statusCode))")
                }
                
        }
    }
}
