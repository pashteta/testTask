//
//  BreweriesCustomCell.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import SafariServices

typealias BreweriesCompletionHanlder = () -> ()

class BreweriesCustomCell: BaseTableViewCell {
    
    // MARK: - IBOutlet's
    
    @IBOutlet private weak var customContentView: UIView!
    
    @IBOutlet private weak var headerLabel: UILabel!
    
    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var countryLabelStackViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var stateNameLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var stateLabelStackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var cityLabelStackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var streetNameLabel: UILabel!
    @IBOutlet private weak var streetLabel: UILabel!
    @IBOutlet private weak var streetLabelStackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var phoneNameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var phoneLabelStackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var webSiteNameLabel: UILabel!
    @IBOutlet private weak var webSiteLabel: UILabel!
    @IBOutlet private weak var webSiteLabelStackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var showOnMapButton: UIButton!
    @IBOutlet private weak var showOnMapButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    private var labelStackViewHeight = CGFloat(20.5)
    private var showOnMapButtonHeight = CGFloat(30.0)
    
    var completion: BreweriesCompletionHanlder?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupElements()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    
    @IBAction func showOnMapButtonClicked(_ sender: Any) {
        if let completion = self.completion {
            completion()
        }
    }
    
    public func setupModel(_ model: BreweriesListViewModel) {
        if let name = model.name {
            self.headerLabel.text = name
        }
        
        self.setupLabelModel(self.countryNameLabel, self.countryLabel, model.country, self.countryLabelStackViewHeight)
        self.setupLabelModel(self.stateNameLabel, self.stateLabel, model.state, self.stateLabelStackViewHeightConstraint)
        self.setupLabelModel(self.cityNameLabel, self.cityLabel, model.phone, self.cityLabelStackViewHeightConstraint)
        self.setupLabelModel(self.streetNameLabel, self.streetLabel, model.city, self.streetLabelStackViewHeightConstraint)
        self.setupLabelModel(self.phoneNameLabel, self.phoneLabel, model.street, self.phoneLabelStackViewHeightConstraint)
        self.setupLabelModel(self.webSiteNameLabel, self.webSiteLabel, model.websiteUrl, self.webSiteLabelStackViewHeightConstraint)
        
        if let webSiteUrl = model.websiteUrl, webSiteUrl.hasChars() {
            self.webSiteLabel.isUserInteractionEnabled = true
            self.webSiteLabel.attributedText = NSAttributedString(string: webSiteUrl, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
        }
        
        if model.latitude != nil && model.longitude != nil {
            self.showOnMapButton.isHidden = false
            self.showOnMapButtonHeightConstraint.constant = self.showOnMapButtonHeight
        } else {
            self.showOnMapButton.isHidden = true
            self.showOnMapButtonHeightConstraint.constant = 0.0
        }
    }
    
    private func setupLabelModel(_ nameLabel: UILabel, _ textLabel: UILabel, _ modelText: String?,_ stackViewConstraint: NSLayoutConstraint) {
        if let text = modelText, text.hasChars() {
            textLabel.text = text
            
            nameLabel.isHidden = false
            textLabel.isHidden = false
            stackViewConstraint.constant = self.labelStackViewHeight
        } else {
            nameLabel.isHidden = true
            textLabel.isHidden = true
            stackViewConstraint.constant = 0.0
        }
    }
    
    // MARK: - Helpers
    
    private func setupElements() {
        self.customContentView.backgroundColor = .groupTableViewBackground
        self.customContentView.layer.cornerRadius = 10.0
        self.customContentView.layer.borderWidth = 1.0
        self.customContentView.layer.borderColor = #colorLiteral(red: 0.1773116291, green: 0.5346951485, blue: 0.01305136736, alpha: 1)
        
        self.headerLabel.font = UIFont.normal(size: 20.0, .regular)
        self.headerLabel.adjustsFontSizeToFitWidth = true
        self.headerLabel.minimumScaleFactor = 0.2
        self.headerLabel.textColor = .black
        
        self.commonLabelSetup(self.countryNameLabel, self.countryLabel, "Country: ".localized)
        self.commonLabelSetup(self.stateNameLabel, self.stateLabel, "State: ".localized)
        self.commonLabelSetup(self.cityNameLabel, self.cityLabel, "City: ".localized)
        self.commonLabelSetup(self.phoneNameLabel, self.phoneLabel, "Phone: ".localized)
        self.commonLabelSetup(self.streetNameLabel, self.streetLabel, "Street: ".localized)
        self.commonLabelSetup(self.webSiteNameLabel, self.webSiteLabel, "Website: ".localized)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(linkTapped))
        self.webSiteLabel.isUserInteractionEnabled = true
        self.webSiteLabel.addGestureRecognizer(tap)
        
        self.showOnMapButton.setTitle("Show on map".localized, for: .normal)
        self.showOnMapButton.setTitleColor(.white, for: .normal)
        self.showOnMapButton.titleLabel?.font = UIFont.normal(size: 13.0, .regular)
        self.showOnMapButton.backgroundColor = #colorLiteral(red: 0.1773116291, green: 0.5346951485, blue: 0.01305136736, alpha: 1)
        self.showOnMapButton.layer.cornerRadius = 8.0
    }
    
    @objc func linkTapped() {
        if let url = URL(string: self.webSiteLabel.text ?? "") {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            if var topController = RouterSerice.getCurrentRoot() {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                topController.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    private func commonLabelSetup(_ nameLabel: UILabel, _ contentLabel: UILabel, _ text: String) {
        nameLabel.font = UIFont.normal(size: 11.0, .regular)
        nameLabel.text = text
        nameLabel.textColor = .gray
        
        contentLabel.font = UIFont.normal(size: 11.0, .regular)
        contentLabel.textColor = .black
        contentLabel.alpha = 0.75
    }
}

// MARK: - BreweriesCustomCell extensiosn -

// MARK: - SFSafariViewControllerDelegate

extension BreweriesCustomCell: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil) 
    }
}
