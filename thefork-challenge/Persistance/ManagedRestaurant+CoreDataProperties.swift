//
//  ManagedRestaurant+CoreDataProperties.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//
//

import Foundation
import CoreData


extension ManagedRestaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedRestaurant> {
        return NSFetchRequest<ManagedRestaurant>(entityName: "ManagedRestaurant")
    }

    @NSManaged public var restaurantID: String?
    @NSManaged public var name: String?
    @NSManaged public var servesCuisine: String?
    @NSManaged public var rating: Double
    @NSManaged public var address: String?

}
