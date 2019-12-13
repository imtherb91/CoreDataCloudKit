//
//  HomeViewController.swift
//  CoreDataCloudKit
//
//  Created by Luke Allen on 12/13/19.
//  Copyright © 2019 Luke Allen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tesla Shopping Cart"
        viewModel = HomeViewModel(delegate: self)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }

    @objc func addItem() {
        let alert = UIAlertController(title: "Add Tesla Product", message: nil, preferredStyle: .alert)
        alert.addTextField { (field) in
            field.placeholder = "Name"
            field.tag = HomeViewModel.TeslaFieldType.name
        }
        alert.addTextField { (field) in
            field.placeholder = "Variant"
            field.tag = HomeViewModel.TeslaFieldType.variant
        }
        alert.addTextField { (field) in
            field.placeholder = "Price"
            field.keyboardType = .numberPad
            field.tag = HomeViewModel.TeslaFieldType.price
        }
        let submitAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let name = alert.textFields![HomeViewModel.TeslaFieldType.name].text
            let variant = alert.textFields![HomeViewModel.TeslaFieldType.variant].text
            let price = alert.textFields![HomeViewModel.TeslaFieldType.price].text
            CoreDataManager.saveTeslaProduct(name: name, variant: variant, price: Int(price ?? "0"))
        }
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }

}

extension HomeViewController: HomeViewModelDelegate {
    
    func dataDidUpdate() {
        tableView.reloadData()
    }
    
}
