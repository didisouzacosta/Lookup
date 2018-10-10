//
//  String+LookupIdentifiable.swift
//  Lookup
//
//  Created by Adriano Costa on 10/10/18.
//

import Foundation

extension String: LookupIdentifiable {
    
    public var reuseIdentifier: String {
        return self
    }
    
    public var nib: UINib {
        return UINib(nibName: self, bundle: Bundle.main)
    }

}
