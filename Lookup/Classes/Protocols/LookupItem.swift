//
//  LookupItem.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

import UIKit

public protocol LookupItem: Equatable {
    var lookupItemLabel: String? { get }
    var lookupItemTitle: String? { get }
    var lookupItemDescription: String? { get }
    var lookupItemImage: UIImage? { get }
    var lookupItemIgnoreAcessory: Bool { get }
}

public extension LookupItem {
    
    public var lookupItemIgnoreAcessory: Bool {
        return false
    }
    
}
