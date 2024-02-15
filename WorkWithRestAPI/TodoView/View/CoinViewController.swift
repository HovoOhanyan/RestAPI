//
//  ViewController.swift
//  WorkWithRestAPI
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import UIKit

final class CoinViewController: UIViewController {
    let tableView = UITableView()
    
    var model = CoinPageModel()
    
    var viewModel = AppDelegate.shared?.container.resolve(IViewModel.self)
    
    private let activityIndicator = UIActivityIndicatorView()
    var isLoading = false
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        fetchData()
        setupDelegates()
    }
    
    private func setupUI() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupDelegates() {
        tableView.register(CoinCell.self, forCellReuseIdentifier: CoinCell.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchData() {
        var parameters: HTTPParameters {
            var parameters = [String: Any]()
            parameters["limit"] = 20
            parameters["currency"] = "EUR"
            return parameters
        }
        
        activityIndicator.startAnimating()
        Task {
            let coins = try await viewModel?.getCoins(parameters: parameters)
            
            if let coins {
                model.coins = coins
            }
            
            tableView.reloadData()
            activityIndicator.stopAnimating()
        }
        
    }
    
    func addData() {
        var parameters: HTTPParameters {
            var parameters = [String: Any]()
            parameters["page"] = page
            parameters["limit"] = 20
            parameters["currency"] = "EUR"
            return parameters
        }
        
        activityIndicator.startAnimating()
        
        Task {
            let coins = try await viewModel?.getCoins(parameters: parameters)
            
            if let coins {
                model.coins += coins
            }
            
            tableView.reloadData()
            activityIndicator.stopAnimating()
        }
        
        self.page += 1
    }
}
