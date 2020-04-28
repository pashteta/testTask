//
//  Breweries+CoreDataClass.swift
//  
//
//  Created by User on 4/14/20.
//
//

import Foundation
import CoreData

@objc(Breweries)
public class Breweries: NSManagedObject {

    class func create(brewery: BreweriesListViewModel, context: NSManagedObjectContext) -> Breweries? {
        
        guard let breweryId = brewery.id else { return nil }
        
        var object = self.get(breweryId: breweryId, context: context)
        
        if object == nil {
            object = NSEntityDescription.insertNewObject(forEntityName: Breweries.className(), into: context) as? Breweries
        }
        
        if let object = object {
            object.id = Int32(brewery.id ?? -1)
            object.name = brewery.name
            object.city = brewery.city
            object.country = brewery.country
            object.latitude = brewery.latitude
            object.longitude = brewery.longitude
            object.phone = brewery.phone
            object.state = brewery.state
            object.street = brewery.street
            object.webSite = brewery.websiteUrl
            
            return object
        }
        
        return nil
    }
    
    class func get(breweryId: Int, context: NSManagedObjectContext) -> Breweries? {
        let idPredicate = NSPredicate.init(format: "id == %@", NSNumber.init(value: breweryId))
        
        let fetchRequest = NSFetchRequest<Breweries>(entityName: Breweries.className())
        fetchRequest.predicate = idPredicate
        
        do {
            let object = try context.fetch(fetchRequest)
            return object.first
        } catch (let error) {
            print("CORE DATA ERROR -> \(error)")
            return nil
        }
    }
}
