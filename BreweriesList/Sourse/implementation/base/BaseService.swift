
import UIKit

class BaseService: NSObject {
    class func storyboardName() -> String {
        return self.className()
    }
    
    class func initialVC() -> UIViewController! {
        let vc = self.getStoryboard().instantiateInitialViewController()
        return vc
    }
    
    class func viewControllerWithIdentifier(_ identifier: String) -> UIViewController! {
        let vc = self.getStoryboard().instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    class func getStoryboard() -> UIStoryboard! {
        let storyboard = UIStoryboard.init(name: self.storyboardName(), bundle: Bundle.main)
        return storyboard
    }
    
    required override init() {

    }
}
