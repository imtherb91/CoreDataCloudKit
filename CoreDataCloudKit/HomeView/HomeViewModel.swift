//
//  HomeViewModel.swift
//  CoreDataCloudKit
//
//  Created by Luke Allen on 12/13/19.
//  Copyright © 2019 Luke Allen. All rights reserved.
//

import UIKit
import CoreData

protocol HomeViewModelDelegate: class {
    func dataDidUpdate()
}

class HomeViewModel: NSObject {
    
    var fetchedResultsController: NSFetchedResultsController<TeslaProduct>?
    weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate) {
        super.init()
        self.delegate = delegate
        setFetchedResultsController()
        fetchData()
    }
    
    func setFetchedResultsController() {
        let fetch = NSFetchRequest<TeslaProduct>(entityName: "TeslaProduct")
        fetch.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetch, managedObjectContext: CoreDataManager.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
    }
    
    func fetchData() {
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error fetching products")
        }
    }
    
}

extension HomeViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.dataDidUpdate()
    }
}

extension HomeViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = fetchedResultsController?.object(at: indexPath)
        return TeslaProductCell(name: product?.name, variant: product?.variant, price: product?.priceString)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        guard let product = fetchedResultsController?.object(at: indexPath) else { return }
        CoreDataManager.managedContext.delete(product)
        CoreDataManager.shared.saveContext()
    }
    
}

extension HomeViewModel {
    enum TeslaFieldType {
        static let name = 0
        static let variant = 1
        static let price = 2
    }
}
