//
//  RouterService.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class RouterSerice: NSObject {
    class func setupScreenFlow() {
        RouterSerice.openMainFlow()
    }
    
    class func openMainFlow() {
        RouterSerice.open(BreweriesService.initialVC())
    }
    
    class func open(_ viewConroller: UIViewController!) {
        UIApplication.shared.keyWindow?.rootViewController = viewConroller
    }
    
    class func getCurrentRoot() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
}
