//
//  String+LookupItem.swift
//  Lookup
//
//  Created by Adriano Costa on 10/10/18.
//

import Foundation

extension String: LookupItem {
    
    public var lookupItemTitle: String? {
        return self
    }
    
    public var editActions: [LookupEditActionRepresentable] {
        return [
            LookupEditAction(title: "Teste", style: .default) { print("Aeeee") }
        ]
    }
    
}
