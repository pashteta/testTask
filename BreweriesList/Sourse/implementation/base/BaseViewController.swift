
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.view.endEditing(true)
    }

    // MARK: - Helpers
    
    private func setupNavigationBar() {
        if let navVC = self.navigationController {
            navVC.navigationBar.barTintColor = #colorLiteral(red: 0.1773116291, green: 0.5346951485, blue: 0.01305136736, alpha: 1)
            navVC.navigationBar.isTranslucent = false
            navVC.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navVC.navigationBar.shadowImage = UIImage()
            
            navVC.navigationBar.titleTextAttributes = [ .foregroundColor : UIColor.white,
                                                        .font : UIFont.normal(size: 22.0, .regular) ]
            
            UIBarButtonItem.appearance().setTitleTextAttributes([ .font : UIFont.normal(size: 16.0, .regular) ], for: .normal)
            UIBarButtonItem.appearance().setTitleTextAttributes([ .font : UIFont.normal(size: 16.0, .regular) ], for: .disabled)
        }
    }
}

