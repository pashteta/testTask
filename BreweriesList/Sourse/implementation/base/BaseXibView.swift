
import UIKit

class BaseXibView: UIView {
    
    @IBOutlet var contentView: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.xibSetup()
    }

    func loadViewFromNib() -> UIView? {
        guard let nibName = NSStringFromClass(type(of: self)).split(separator: ".").last else {
            return UIView()
        }
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(nibName), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    private func xibSetup() {
        guard let view = self.loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        self.contentView = view
    }
}
