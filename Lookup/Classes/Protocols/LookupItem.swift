//
//  LookupItem.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

public protocol LookupItem {
    var lookupItemLabel: String? { get }
    var lookupItemTitle: String? { get }
    var lookupItemDescription: String? { get }
    var lookupItemImage: UIImage? { get }
}
