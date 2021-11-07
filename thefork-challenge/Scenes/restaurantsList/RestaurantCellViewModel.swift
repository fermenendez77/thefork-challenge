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
    let imageDownloaderService : ImageDownloader
    
    public init(with restaurant : Restaurant,
                imageDownloader : ImageDownloader = ImageDownloaderService(),
                persistanceService : RestaurantsPersistance) {
        self.restaurant = restaurant
        self.persistanceService = persistanceService
        self.imageDownloaderService = imageDownloader
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
        guard let urlString = restaurant.mainPhoto?.the612X344 else {
            return
        }
        
        imageDownloaderService.getImage(from: URL(string: urlString),
                                        completionHandler: { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let image):
                self.image.value = image
            case .failure(let error):
                print(error)
                self.image.value = UIImage(named: "placeholder")
            }
        })
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
