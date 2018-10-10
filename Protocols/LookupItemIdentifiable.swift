//
//  LookupIdentifiable.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation

public protocol LookupIdentifiable {
    var reuseIdentifier: String { get }
    var nib: UINib { get }
}
