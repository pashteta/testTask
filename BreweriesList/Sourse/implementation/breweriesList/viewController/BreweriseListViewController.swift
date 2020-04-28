//
//  BreweriseListViewController.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class BreweriseListViewController: BaseViewController {
    
    // MARK: - IBOutlet's
    
    @IBOutlet private weak var customSearchBarView: CustomSearchBarView!
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let service = BreweriesService()
    
    private var selectedModel: BreweriesListViewModel?
    
    // MARK: - Business logic
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCompletions()
        
        self.setupElements()
        self.getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MapViewController.className() {
            let vc = segue.destination as! MapViewController
            
            if let selectedModel = self.selectedModel {
                vc.latitude = selectedModel.latitude
                vc.longitude = selectedModel.longitude
                vc.name = selectedModel.name
            }
        }
    }
    
    // MARK: - Actions
    
    public func setupCompletions() {
        self.customSearchBarView.completion = { [weak self] (text) in
            guard let strongSelf = self else { return }
            
            strongSelf.makeSearchRequest(strongSelf.customSearchBarView.textField.text ?? "")
        }
    }
    
    private func makeSearchRequest(_ searchText: String) {
        ActivityIndicatorView.showActivity()
        
        self.service.findBreweries(searchText) { [weak self] (error) in
            
            ActivityIndicatorView.hideAllActivity()
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("ERRRORO: ",error)
            } else {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    private func getData() {
        ActivityIndicatorView.showActivity()
        
        self.service.getAllBrewerise { [weak self] (error) in
            
            ActivityIndicatorView.hideAllActivity()
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("ERRRORO: ",error)
            } else {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Helpers
    
    private func setupElements() {
        self.navigationItem.title = "Breweries".localized
        self.navigationItem.titleView?.backgroundColor = .green
        self.navigationItem.titleView?.tintColor = .white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.0001))
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        
        self.tableView.register(BreweriesCustomCell.nib(), forCellReuseIdentifier: BreweriesCustomCell.identifier())
    }
}

// MARK: - BreweriseListViewController Extension -

// MARK: - UITableViewDelegate, UITableViewDataSource

extension BreweriseListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.service.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentModel = self.service.dataSource[indexPath.row]
        return currentModel.breweryHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentModel = self.service.dataSource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BreweriesCustomCell.identifier(), for: indexPath) as! BreweriesCustomCell
        
        cell.completion = { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.selectedModel = currentModel
            strongSelf.performSegue(withIdentifier: MapViewController.className(), sender: self)
        }

        cell.setupModel(currentModel)
        
        return cell
    }
}

