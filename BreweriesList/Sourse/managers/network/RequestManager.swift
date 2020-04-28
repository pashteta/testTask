//
//  RequestManager.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import Alamofire
import Foundation

public enum ResultRequest {
    case success(Any)
    case error(Error)
}

public typealias JSON = [ String : Any ]
public typealias completion = (ResultRequest) -> Void

class RequestManager {
    static let shared = RequestManager()
    
    // MARK: - Request functions
    
    func request(url: String, parameters: JSON?, requestMethod: HTTPMethod, completion: @escaping completion) {
        print("\n\n<<< REQUEST PARAMS >>>\n\n >>> Url - \(url) \n >>> Params - \(parameters as AnyObject)\n\n")
        
        AF.request(url, method: requestMethod, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData { [weak self] response in
            guard let strongSelf = self else { completion(.error(RequestUtilities.getEmptyError())); return }
            strongSelf.parseResponse(response: response, completion: completion)
        }
    }
    
    // MARK: - Parsers
    
    private func parseResponse(response: AFDataResponse<Data>, completion: @escaping completion) {
        guard let statusCode = response.response?.statusCode else { completion(.error(RequestUtilities.getEmptyError())); return }
        
        let url = response.request?.url?.absoluteString ?? "Empty URL"
        let method = String(describing: response.request?.httpMethod)
        let headers = String(describing: response.request?.allHTTPHeaderFields)
        
        if statusCode == 200 {
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    print("\n\n<<< RESPONSE - SUCCESS - \(statusCode) >>>\n\n >>> Url - \(url) \n >>> Method - \(method) \n >>> Response - \(json) \n >>> Headers - \(headers)\n\n")
                    
                    completion(.success(json))
                } catch let error {
                    completion(.error(error))
                }
            } else {
                completion(.error(RequestUtilities.getEmptyError()))
            }
        } else {
            var errorResponse = ""
            if let data = response.data {
                errorResponse = String(decoding: data, as: UTF8.self)
            }
            
            print("\n\n<<< RESPONSE - ERROR - \(statusCode) >>>\n\n >>> Url - \(url) \n >>> Method - \(method) \n >>> Response - \(errorResponse) \n >>> Headers - \(headers)\n\n")
            
            completion(.error(RequestUtilities.getErrorWithMessageAndCode(statusCode, message: errorResponse)))
        }
    }
    
}
