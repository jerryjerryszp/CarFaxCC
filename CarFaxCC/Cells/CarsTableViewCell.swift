//
//  CarsTableViewCell.swift
//  CarFaxCC
//
//  Created by Jerry Shi on 2020-09-17.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CarsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carInfoLabel: UILabel!
    @IBOutlet weak var carDetailsLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    // MARK: - Properties
    var carViewModel: CarViewModel?
    var disposeBag = DisposeBag()
    var callButtonTap: Observable<Void> {
        return self.callButton.rx.tap.asObservable()
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
