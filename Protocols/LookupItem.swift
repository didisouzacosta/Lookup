//
//  LookupItem.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

public protocol LookupItem {
    var editActions: [LookupEditActionRepresentable] { get }
    var lookupItemTitle: String? { get }
}

extension LookupItem {
    
    public var editActions: [LookupEditActionRepresentable] {
        return []
    }
    
}
