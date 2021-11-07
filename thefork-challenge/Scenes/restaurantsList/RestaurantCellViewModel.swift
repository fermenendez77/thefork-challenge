//
//  RestaurantCellViewModel.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation
import UIKit

class RestaurantCellViewModel {
    
    var restaurant : Restaurant
    let persistanceService : RestaurantsPersistance
    
    public init(with restaurant : Restaurant,
                persistanceService : RestaurantsPersistance) {
        self.restaurant = restaurant
        self.persistanceService = persistanceService
        self.isSaved = Binding(restaurant.isSaved)
        getImage()
    }
    
    var name : String { restaurant.name }
    var rating : String { restaurant.aggregateRatings.thefork?.ratingValue.description ?? "N/A" }
    var type : String { restaurant.servesCuisine.uppercased() }
    var averagePrice : String { "Average price \(restaurant.priceRange) \(restaurant.currenciesAccepted.rawValue)" }
    var address : String {"\(restaurant.address.street), \(restaurant.address.postalCode), \(restaurant.address.locality ?? "")"}
    
    var image : Binding<UIImage?> = Binding(nil)
    var isSaved : Binding<Bool>
    
    func getImage() {
        
        guard let urlString = restaurant.mainPhoto?.the612X344,
              let url = URL(string: urlString) else {
                  return
              }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self.image.value = UIImage(data: data)
            }
        }
    }
    
    func toggleSaved() {
        if restaurant.isSaved {
            let result = persistanceService.delete(restaurant: restaurant)
            restaurant.isSaved = !result
        } else {
            persistanceService.save(restaurant: restaurant)
            restaurant.isSaved = true
        }
        self.isSaved.value = restaurant.isSaved
    }
}
