//
//  Restaurant.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

struct Restaurant: Codable {
    
    let name, uuid, servesCuisine: String
    let priceRange: Int
    let currenciesAccepted: Currencies
    let address: Address
    let aggregateRatings: AggregateRatings
    let mainPhoto: MainPhoto?
    let bestOffer: Offer
    
    var rating : Double {
        aggregateRatings.thefork?.ratingValue ?? 0.0
    }
}
