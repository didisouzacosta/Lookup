//
//  LookupSearch.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

public struct LookupSearch: LookupSearcheable {
    
    // MARK: - Public Variables
    
    public var page: Int
    public var limit: Int
    public var term: String = ""
    public var scopes: [String] = []
    public var selectedScope: Int?
    public var placeholder: String?
    public var offset: Int
    public var searcheable: Bool
    
    // MARK: - Life Cycle
    
    public init(page: Int = 1, limit: Int = 30, term: String = "", scopes: [String] = [], selectedScope: Int? = nil, placeholder: String? = nil, offset: Int = 10, searcheable: Bool = true) {
        self.page = page
        self.limit = limit
        self.term = term
        self.scopes = scopes
        self.selectedScope = selectedScope
        self.placeholder = placeholder
        self.offset = offset
        self.searcheable = searcheable
    }
    
}
