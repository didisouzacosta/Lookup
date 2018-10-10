//
//  LookupDefaultIdentify.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

struct LookupDefaultIdentifier: LookupIdentifiable {
    
    var reuseIdentifier: String {
        return "LookupDefaultCell"
    }
    
    var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: Bundle(for: LookupDefaultCell.self))
    }
    
}
