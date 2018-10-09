//
//  LookupCellIdentifier.swift
//  Lookup
//
//  Created by Adriano Costa on 08/10/18.
//

import Foundation
import UIKit

public struct LookupCellIdentifier: LookupItemIdentifiable {
    
    public var identifier: String
    public var nibName: String
    public var bundle: Bundle
    
    public init(_ identifier: String, nibName: String? = nil, bundle: Bundle = Bundle.main) {
        self.identifier = identifier
        self.nibName = nibName ?? identifier
        self.bundle = bundle
    }
    
}
