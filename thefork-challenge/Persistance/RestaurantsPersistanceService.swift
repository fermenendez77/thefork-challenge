//
//  RestaurantsPersistanceService.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//

import Foundation

protocol RestaurantsPersistance {
    
    func fetchSaved() -> [ManagedRestaurant]
    func save(restaurant : Restaurant)
    func delete(restaurant : Restaurant) -> Bool
}

class RestaurantPersistanceService : RestaurantsPersistance {
    
    let context = CoreDataManager.shared.viewContext
    
    func fetchSaved() -> [ManagedRestaurant] {
        let fetchRequest = ManagedRestaurant.fetchRequest()
        var savedRestaurants : [ManagedRestaurant] = []
        do {
            savedRestaurants = try context.fetch(fetchRequest)
        } catch  {
            print(error)
        }
        return savedRestaurants
    }
    
    func save(restaurant : Restaurant) {
        let managedRestaurant = ManagedRestaurant(context: context)
        managedRestaurant.setData(from: restaurant)
        CoreDataManager.shared.save()
    }
    
    func delete(restaurant : Restaurant) -> Bool {
        let fetchRequest = ManagedRestaurant.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID == %@", restaurant.uuid)
        fetchRequest.predicate = predicate
        do {
            if let managedObject = try context.fetch(fetchRequest).first {
                context.delete(managedObject)
                return true
            } else {
                return false
            }
        } catch  {
            return false
        }
    }
}

