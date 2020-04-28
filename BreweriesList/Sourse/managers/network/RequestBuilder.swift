//
//  RequestBuilder.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation
import UIKit

enum Result<T> {
    case success(T)
    case error(Error)
}

// MARK: - Handlers

// MARK: - Breweries List

typealias GetBreweriesList = (Result<[BreweriesListNetworkModel]>) -> ()

class RequestBuilder {
    
    // MARK: - Requests -
    
    // MARK: - Breweries List Request
    
    class func getAllBreweries(_ completion: @escaping GetBreweriesList) {
        RequestManager.shared.request(url: BreweriesPaths.Request.breweries.url(), parameters: nil, requestMethod: .get) { (result) in
            RequestBuilder.breweriesParser(result, completion)
        }
    }
    
    // MARK: - Breweries Search Request
    
    class func breweriesSearch(_ title: String, _ completion: @escaping GetBreweriesList) {
        RequestManager.shared.request(url: BreweriesPathsSearch.Request.byName.url() + title, parameters: nil, requestMethod: .get) { (result) in
            RequestBuilder.breweriesParser(result, completion)
        }
    }
   
    // MARK: - Breweries parsers
       
    private class func breweriesParser(_ result: ResultRequest, _ completion: @escaping GetBreweriesList) {
        switch result {
        case let .success(response):
            if let response = response as? [ [ String: Any ] ] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: response)
                    let result = try JSONDecoder().decode([BreweriesListNetworkModel].self, from: jsonData)
                    
                    completion(.success(result))
                } catch {
                    completion(.error(RequestUtilities.getIncorrectDataFormat(response)))
                }
            }
        case let .error(error):
            completion(.error(error))
        }
    }
}
