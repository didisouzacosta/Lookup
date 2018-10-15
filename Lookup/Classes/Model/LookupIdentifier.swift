//
//  LookupIdentify.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation
import UIKit

public struct LookupIdentifier: LookupIdentifiable {
    
    public var reuseIdentifier: String
    public var nib: UINib
    
    public init(reuseIdentifier: String, nib: UINib) {
        self.reuseIdentifier = reuseIdentifier
        self.nib = nib
    }
    
}
