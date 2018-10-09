//
//  LookupDefaultCellIdentifier.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

class LookupDefaultCellIdentifier: LookupCellIdentifiable {
    
    var identifier: String {
        return "LookupDefaultCell"
    }
    
    var bundle: Bundle {
        return Bundle(for: LookupDefaultCell.self)
    }
    
}
