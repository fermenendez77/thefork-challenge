//
//  Rating.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

struct AggregateRatings: Codable {
    let thefork, tripadvisor: Rating?
}

struct Rating: Codable {
    let ratingValue: Double
    let reviewCount: Int
}
