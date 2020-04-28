//
//  RequestPath.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

// MARK: - Domains

public enum BaseURL {
    static let domain = "https://api.openbrewerydb.org"
}

// MARK: - Breweries List

public enum BreweriesPaths {
    static let endpoint = "/"
    
    enum Request: String {
        case breweries = "breweries"
        
        func url() -> String { return BaseURL.domain + BreweriesPaths.endpoint + rawValue }
    }
}

// MARK: - BreweriesPathsSearch

public enum BreweriesPathsSearch {
    static let endpoint = "/breweries"
    
    enum Request: String {
        case byName = "/?by_name="
        
        func url() -> String { return BaseURL.domain + BreweriesPathsSearch.endpoint + rawValue }
    }
}
