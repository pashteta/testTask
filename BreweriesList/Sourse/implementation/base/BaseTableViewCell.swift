
import UIKit

class BaseTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func nib() -> UINib {
        return UINib.init(nibName: self.identifier(), bundle: nil)
    }
    
    class func identifier() -> String {
        return self.className()
    }
    
    class func height() -> CGFloat {
        return 44.0
    }
}
