//
//  CustomSearchBarView.swift
//  BreweriesList
//
//  Created by User on 4/14/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

typealias CustomSearchBarViewChangeValueHandler = (String) -> ()

class CustomSearchBarView: BaseXibView {
    
    // MARK: - IBOutlet'S
    
    @IBOutlet private weak var backgroundSearchBarView: UIView!
    @IBOutlet private weak var separatorView: UIView!
    
    @IBOutlet private weak var searchImageView: UIImageView!
    @IBOutlet private weak var contentBackgroundView: UIView!
    @IBOutlet private weak var placeholderLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet private var placeholderLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var completion: CustomSearchBarViewChangeValueHandler?
    private var timer: Timer?
    
    // MARK: - Business logic
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupElements()
        self.updatePlaceholderState(inCenter: true)
    }
    
    deinit {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    // MARK: - Actions
    
    @objc private func textFieldChangeValue(_ textField: UITextField) {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(shouldUpdateInterface),
                                          userInfo: nil,
                                          repeats: false)
    }
    
    @objc private func shouldUpdateInterface() {
        if let completion = self.completion {
            completion(textField.text ?? "")
        }
    }
    
    private func updatePlaceholderState(inCenter: Bool) {
        self.placeholderLeadingConstraint.isActive = !inCenter
        UIView.animate(withDuration: 0.1) {
            self.placeholderLabel.alpha = (inCenter) ? 1.0 : 0.0
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Helpers
    
    func setupElements() {
        self.separatorView.backgroundColor = .black
        self.separatorView.alpha = 0.25

        self.contentBackgroundView.layer.cornerRadius = 10.0
        self.contentBackgroundView.clipsToBounds = true
        self.contentBackgroundView.backgroundColor = .white
        
        self.backgroundSearchBarView.backgroundColor = #colorLiteral(red: 0.1773116291, green: 0.5346951485, blue: 0.01305136736, alpha: 1)

        self.searchImageView.tintColor = .gray
        
        self.placeholderLabel.font = UIFont.normal(size: 17.0, .regular)
        self.placeholderLabel.textColor = .gray
        self.placeholderLabel.text = "Search".localized
        self.placeholderLabel.backgroundColor = UIColor.clear
        self.placeholderLabel.alpha = 1.0
        
        self.textField.font = self.placeholderLabel.font
        self.textField.textColor = self.placeholderLabel.textColor.withAlphaComponent(1.0)
        self.textField.backgroundColor = UIColor.clear
        self.textField.text = ""
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textFieldChangeValue(_:)), for: .editingChanged)
        self.textField.backgroundColor = UIColor.clear
        self.textField.adjustsFontSizeToFitWidth = true
        self.textField.minimumFontSize = 12.0
        self.textField.returnKeyType = .done
    }
}
// MARK: - CustomSearchBarView extensions -

// MARK: - UITextFieldDelegate

extension CustomSearchBarView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.updatePlaceholderState(inCenter: false)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let inCenter = !(self.textField.text?.hasChars() ?? false)
        self.updatePlaceholderState(inCenter: inCenter)
        return true
    }
}

