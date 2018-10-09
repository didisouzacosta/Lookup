//
//  LookupDefaultCellIdentifier.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

class LookupDefaultCellIdentifier: LookupItemIdentifiable {
    
    var identifier: String {
        return "LookupDefaultCell"
    }
    
    var nibName: String {
        return "LookupDefaultCell"
    }
    
    var bundle: Bundle {
        return Bundle(for: LookupDefaultCell.self)
    }
    
}
