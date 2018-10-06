//
//  LookupItemCell.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation

public protocol LookupItemCell {
    
    static var lookupCellIdentifier: String { get }
    static var lookupCellNib: UINib { get }
    
    func setup(with item: LookupItem)
    
}
