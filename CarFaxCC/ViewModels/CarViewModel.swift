//
//  CarViewModel.swift
//  CarFaxCC
//
//  Created by Jerry Shi on 2020-09-17.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation

struct CarViewModel {
    private let car: Car
    
    var carImageUrl: String {
        return car.images.medium.first ?? ""
    }
    
    var carInfo: String {
        let carTrim = car.trim == "Unspecified" ? "" : car.trim
        return [String(car.year), car.make, car.model, carTrim].joined(separator: " ")
    }
    
    var carDetails: String {
        let onePrice = car.onePrice.rounded(.towardZero)
        var priceString = "$"
        if let price = String(format: "%f", onePrice).split(separator: ".").first {
            priceString = "$\(price)"
        } else {
            priceString = String(format: "%f", onePrice)
        }
        
        let mileage = String(car.mileage) + " km"
        let location =  [car.dealer.address, car.dealer.state].joined(separator: ", ")
        
        return [priceString, mileage, location].joined(separator: " | ")
    }
    
    var phoneNumber: String {
        return car.dealer.phone
    }
    
    init(car: Car) {
        self.car = car
    }
    
}
