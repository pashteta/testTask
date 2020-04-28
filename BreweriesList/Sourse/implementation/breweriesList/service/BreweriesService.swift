//
//  BreweriesService.swift
//  BreweriesList
//
//  Created by User on 4/13/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation
import CoreData

private let cNameBrewelesStoryboardName = "BreweriesList"

class BreweriesService: BaseService {
    
    public var dataSource: [BreweriesListViewModel] = []
    
    private var filteredDataSource: [BreweriesListViewModel] = []
    
    // MARK: - Navigation
    
    override class func storyboardName() -> String {
        return cNameBrewelesStoryboardName
    }
    
    // MARK: - Network
    
    public func getAllBrewerise(_ completion: @escaping ((Error?) -> Void)) {
        if NetworkConnectionService.isConnectedToNetwork() {
            RequestBuilder.getAllBreweries { (result) in
                switch result {
                case let .success(model):
                    self.setupDataSource(model, false) {
                        completion(nil)
                    }
                case let .error(error):
                    completion(error)
                }
            }
        } else {
            self.dbGetEntity {
                completion(nil)
            }
        }
    }
    
    public func findBreweries(_ searchText: String,_ completion: @escaping ((Error?) -> Void)) {
        if NetworkConnectionService.isConnectedToNetwork() {
            RequestBuilder.breweriesSearch(searchText) { (result) in
                switch result {
                case let .success(model):
                    self.setupDataSource(model, true) {
                        completion(nil)
                    }
                case let .error(error):
                    completion(error)
                }
            }
        } else {
            if searchText.hasChars() {
                self.filterDataSource(searchText) {
                    completion(nil)
                }
            } else {
                self.dbGetEntity {
                    completion(nil)
                }
            }
        }
        
    }
    
    private func filterDataSource(_ searchText: String, _ completion: @escaping () -> Void) {
        self.dataSource = []
        
        for model in self.filteredDataSource {
            if let name = model.name, name.contains(searchText) {
                self.dataSource.append(model)
            }
        }
            
        completion()
    }
    
    // MARK: Setup Interface
    
    private func setupDataSource(_ model: [BreweriesListNetworkModel], _ isSearchDataSource: Bool,_ completion: @escaping () -> Void) {
        var ds: [BreweriesListViewModel] = []
        
        for md in model {
            let viewModel = BreweriesListViewModel.init(md)
            if !isSearchDataSource {
                BreweriesService.dbSaveEntity(viewModel, md.id ?? -1)
            }
            ds.append(viewModel)
        }
        
        self.filteredDataSource = ds
        self.dataSource = ds
        
        completion()
    }
    
    // MARK: - CoreData Source
    
    class func dbSaveEntity(_ breweryModel: BreweriesListViewModel, _ id: Int) {
        _ = Breweries.create(brewery: breweryModel, context: DataBaseManager.shared.managedContext)
        
        DataBaseManager.shared.saveContext()
    }
        
    func dbGetEntity( _ completion: @escaping () -> Void) {
        let fetchRequest = NSFetchRequest<Breweries>(entityName: Breweries.className())
        do {
            let dataModel = try
                DataBaseManager.shared.managedContext.fetch(fetchRequest)
            
            self.setupCoreDataSource(dataModel,completion)
        } catch let error as NSError {
            print("Count not fetch \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Setup Interface
    
    private func setupCoreDataSource(_ model: [Breweries], _ completion: @escaping () -> Void) {
        var ds: [BreweriesListViewModel] = []
        
        for md in model {
            ds.append(BreweriesListViewModel.init(md))
        }
        
        self.filteredDataSource = ds
        self.dataSource = ds
        
        completion()
    }
}

