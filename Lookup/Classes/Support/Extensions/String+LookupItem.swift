//
//  String+LookupItem.swift
//  Lookup
//
//  Created by Adriano Costa on 10/10/18.
//

import Foundation

extension String: LookupItem {
    
    public var lookupItemLabel: String? {
        return nil
    }
    
    public var lookupItemDescription: String? {
        return nil
    }
    
    public var lookupItemTitle: String? {
        return self
    }
    
    public var lookupItemImage: UIImage? {
        return nil
    }
    
}
