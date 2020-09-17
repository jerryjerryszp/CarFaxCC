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
        return [String(car.year), car.make, car.model, car.trim].joined(separator: " ")
    }
    
    var carDetails: String {
        let price = String(format: "%f", car.onePrice)
        let priceString = "$\(price)"
        let mileage = String(car.mileage)
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
