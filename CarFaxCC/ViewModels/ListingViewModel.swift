//
//  ListingViewModel.swift
//  CarFaxCC
//
//  Created by Jerry Shi on 2020-09-17.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import RxSwift

final class ListingViewModel {
    let title = Constants.ListingViewModel.title
    
    private let listingService: ListingServiceProtocol
    
    init(listingService: ListingServiceProtocol = ListingService()) {
        self.listingService = listingService
    }
    
    func fetchCarViewModels() -> Observable<[CarViewModel]> {
        listingService.fetchListingData().map {
            $0.map { CarViewModel(car: $0) }
        }
    }
}
