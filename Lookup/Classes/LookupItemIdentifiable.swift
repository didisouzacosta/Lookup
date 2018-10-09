//
//  LookupItemIdentifiable.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

public protocol LookupCellIdentifiable {
    var identifier: String { get }
    var nibName: String { get }
    var bundle: Bundle { get }
}

extension LookupCellIdentifiable {
    
    public var bundle: Bundle {
        return Bundle.main
    }
    
    var nibName: String {
        return identifier
    }
    
    var nib: UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }
    
}

extension String: LookupCellIdentifiable {
    
    public var identifier: String {
        return self
    }
    
    public var nibName: String {
        return self
    }
    
}
