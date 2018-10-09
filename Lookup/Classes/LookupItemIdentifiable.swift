//
//  LookupItemIdentifiable.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

public protocol LookupItemIdentifiable {
    var lookupItemIdentifier: String { get }
    var lookupItemNib: UINib { get }
}
