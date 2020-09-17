//
//  Car.swift
//  CarFaxCC
//
//  Created by Jerry Shi on 2020-09-17.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation

struct CarResponse: Decodable {
    let listings: [Car]
}

struct Car: Decodable {
    /// Images
    let images: Images
    
    /// year make model trim
    let year: Int
    let make: String
    let model: String
    let trim: String
    
    /// Price
    let onePrice: Double
    
    /// Mileage
    let mileage: Int
    
    let dealer: Dealer
}

/// Images
struct Images: Decodable {
    let baseUrl: String
    let medium: [String]
//    let firstPhoto: FirstPhoto
}

struct FirstPhoto: Decodable {
    let small: String
    let medium: String
    let large: String
}

/// Dealer
struct Dealer: Decodable {
    /// Location and phone
    let address: String
    let phone: String
    let state: String
}
