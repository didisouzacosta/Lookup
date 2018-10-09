//
//  LookupItemIdentifiable.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

public protocol LookupItemIdentifiable {
    var identifier: String { get }
    var nibName: String { get }
    var bundle: Bundle { get }
}

extension LookupItemIdentifiable {
    
    public var bundle: Bundle {
        return Bundle.main
    }
    
    var nib: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }
    
}
