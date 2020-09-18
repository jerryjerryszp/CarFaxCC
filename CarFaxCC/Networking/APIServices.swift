//
//  APIServices.swift
//  CarFaxCC
//
//  Created by Jerry Shi on 2020-09-17.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import RxSwift

protocol ListingServiceProtocol {
    func fetchListingData() -> Observable<[Car]>
}

class ListingService: ListingServiceProtocol {
    /**
     Fetch listing data
    
     - Returns:
         -  [Car]: return the list of cars
     */
    func fetchListingData() -> Observable<[Car]> {
        return Observable.create { observer -> Disposable in
            
            let url = URL(string: Constants.API.carfaxAPI)!

            APIManager.shared.request(url: url, parameters: [:]) { (response, error) in

                if let data = response {
                    do {
                        let result = try JSONDecoder().decode(CarResponse.self, from: data)
                        observer.onNext(result.listings)
                    } catch {
                        observer.onError(error)
                    }
                }
            }

            return Disposables.create {}
        }
    }
}
