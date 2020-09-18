//
//  ViewController.swift
//  CarFaxCC
//
//  Created by Jerry Shi on 2020-09-17.
//  Copyright © 2020 jerryszp6116. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    private var listingViewModel: ListingViewModel?
    
    // MARK: - Lifecycle
    static func instantiate(viewModel: ListingViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.listingViewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
        showListings()
    }

    
    // MARK: - Helpers
    func setupViews() {
        navigationItem.title = listingViewModel?.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(UINib(nibName: String(describing: CarsTableViewCell.self), bundle: nil),
                                      forCellReuseIdentifier: String(describing: CarsTableViewCell.self))
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }

    func showListings() {
        listingViewModel?.fetchCarViewModels()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: "CarsTableViewCell",
                cellType: CarsTableViewCell.self
            )) { row, viewModel, cell in
                ImageCache.loadImage(urlString: viewModel.carImageUrl) { (urlString, image) in
                    
                    cell.carImageView.image = image
                }
                
                cell.carInfoLabel.text = viewModel.carInfo
                cell.carDetailsLabel.text = viewModel.carDetails
                cell.callButton.setTitle(viewModel.phoneNumber, for: .normal)
                
                cell.callButtonTap
                    .subscribe(onNext: {
                        print(viewModel.phoneNumber)
                        self.dialNumber(number: viewModel.phoneNumber)
                        
                    }).disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)
    }
    
    func dialNumber(number : String) {
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
