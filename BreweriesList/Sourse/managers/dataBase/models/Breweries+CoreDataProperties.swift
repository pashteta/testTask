//
//  Breweries+CoreDataProperties.swift
//  
//
//  Created by User on 4/14/20.
//
//

import Foundation
import CoreData

extension Breweries {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Breweries> {
        return NSFetchRequest<Breweries>(entityName: "Breweries")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var state: String?
    @NSManaged public var city: String?
    @NSManaged public var webSite: String?
    @NSManaged public var street: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var phone: String?
    @NSManaged public var id: Int32

}
