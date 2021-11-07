//
//  FavsViewModel.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//

import Foundation
import UIKit

class FavsViewModel {
    
    let persistanceService : RestaurantsPersistance
    
    var data : [ManagedRestaurant] = []
    var isDataLoaded : Binding<Bool> = Binding(false)
    
    init(persistanceService : RestaurantsPersistance = RestaurantPersistanceService() ) {
        self.persistanceService = persistanceService
    }
    
    func fetchData() {
        data = persistanceService.fetchSaved()
        isDataLoaded.value = true
    }
    
    func configure(cell : UITableViewCell, for indexPath : IndexPath) {
        let restaurant = data[indexPath.row]
        cell.textLabel?.text = restaurant.name
        cell.detailTextLabel?.text = restaurant.servesCuisine
    }
}
