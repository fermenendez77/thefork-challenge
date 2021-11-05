//
//  Address.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation

struct Address: Codable {
    let street, postalCode: String
    let locality: String?
    let country: String?
}
