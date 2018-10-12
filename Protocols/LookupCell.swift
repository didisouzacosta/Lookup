//
//  LookupItemCell.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation



public protocol LookupCell {
    static var reuseIdentifier: String { get }
    func setup<T: LookupItem>(with item: T)
}
