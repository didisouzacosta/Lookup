//
//  LookupSearcheable.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

public protocol LookupSearcheable {
    
    var page: Int { get set }
    var limit: Int { get set }
    var term: String? { get set }
    var scopes: [String] { get set }
    var selectedScope: Int? { get set }
    
}

extension LookupSearcheable {
    
    public var scopes: [String] {
        return []
    }
    
    public var selectedScope: Int? {
        return nil
    }
    
}
