//
//  TeslaProduct+Extensions.swift
//  CoreDataCloudKit
//
//  Created by Luke Allen on 12/13/19.
//  Copyright © 2019 Luke Allen. All rights reserved.
//

import Foundation

extension TeslaProduct {
    
    var priceString: String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        return fmt.string(from: price as NSNumber) ?? "$0"
    }
    
}
