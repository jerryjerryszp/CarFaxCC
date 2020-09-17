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
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    }

    
    // MARK: - Helpers
    func setupViews() {
        navigationItem.title = listingViewModel?.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }

}

