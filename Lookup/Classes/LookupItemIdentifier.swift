//
//  LookupItemIdentifier.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

public struct LookupItemIdentifier: LookupItemIdentifiable {
    
    public var lookupItemIdentifier: String
    public var lookupItemNib: UINib
    
    public init(identifier: String, nib: UINib) {
        self.lookupItemIdentifier = identifier
        self.lookupItemNib = nib
    }
    
}
