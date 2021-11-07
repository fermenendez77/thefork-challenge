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
    
    var isSaved : Bool = false
    
    var addressString : String {
        "\(address.street), \(address.postalCode), \(address.locality ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case uuid
        case servesCuisine
        case priceRange
        case currenciesAccepted
        case address
        case aggregateRatings
        case mainPhoto
        case bestOffer
    }
}
