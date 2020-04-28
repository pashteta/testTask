//
//  RequestUtilities.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

// MARK: - Utilities

class RequestUtilities {
    
    // MARK: - ERRORS
    
    class func getErrorWithMessageAndCode(_ code: Int, message: String) -> NSError {
        let error = NSError(domain: BaseURL.domain, code: code, userInfo: [NSLocalizedDescriptionKey: message])
        return error
    }

    class func getEmptyError() -> NSError {
        let error = NSError(domain: BaseURL.domain, code: -3, userInfo: [NSLocalizedDescriptionKey: "Empty error"])
        return error
    }

    class func getIncorrectDataFormat(_ data: Any) -> NSError {
        let error = NSError(domain: BaseURL.domain, code: -3, userInfo: [NSLocalizedDescriptionKey: "Incorrect data format \(data)"])
        return error
    }
}
