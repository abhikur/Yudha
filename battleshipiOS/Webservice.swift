import Foundation
import Alamofire

class Webservice {
    
    func get(url: URL, completion: @escaping (_ jsonRes: DataResponse<Any>) -> Void) {
        Alamofire.request(url)
            .responseJSON { (res) in
                completion(res)
        }
    }
    
    func post(url: URL, parameters: Parameters, completion: @escaping (_ jsonRes: DataResponse<Any>) -> Void) {
        
        let httpHeaders = ["Accept": "application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: httpHeaders)
            .responseJSON { (res) in
                print(Alamofire.SessionManager.defaultHTTPHeaders)
                completion(res)
        }
    }
}
