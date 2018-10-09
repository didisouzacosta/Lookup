//
//  LookupItemDefaultIdentifier.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

class LookupItemDefaultIdentifier<T: LookupItem>: LookupItemIdentifiable {
    
    var lookupItemIdentifier: String {
        return "LookupDefaultCell"
    }
    
    var lookupItemNib: UINib {
        return UINib(nibName: "LookupDefaultCell", bundle: Bundle(for: LookupDefaultCell.self))
    }
    
}
