//
//  TeslaProductCell.swift
//  CoreDataCloudKit
//
//  Created by Luke Allen on 12/13/19.
//  Copyright © 2019 Luke Allen. All rights reserved.
//

import UIKit

class TeslaProductCell: UITableViewCell {
    
    var price = UILabel()
    
    init(name: String?, variant: String?, price: String?) {
        super.init(style: .subtitle, reuseIdentifier: "ProductCell")
        textLabel?.text = name
        detailTextLabel?.text = variant
        setupPrice(price)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPrice(_ str: String?) {
        addSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        price.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor).isActive = true
        price.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        price.text = str
    }
    
}
