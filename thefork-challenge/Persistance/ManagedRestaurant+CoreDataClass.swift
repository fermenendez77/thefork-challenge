//
//  ManagedRestaurant+CoreDataClass.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//
//

import Foundation
import CoreData

@objc(ManagedRestaurant)
public class ManagedRestaurant: NSManagedObject {
    
    func setData(from restaurant: Restaurant) {
        self.restaurantID = restaurant.uuid
        self.name = restaurant.name
        self.rating = restaurant.rating
        self.address = restaurant.addressString
        self.servesCuisine = restaurant.servesCuisine
    }
}
