//
//  LookupSession.swift
//  Lookup
//
//  Created by Adriano Costa on 14/10/18.
//

import Foundation

public class LookupSession<T: LookupItem>: Equatable {
    
    public typealias LookupItemType = T
    
    public var headerTitle: String? = nil
    public var footerTitle: String? = nil
    public var items: [T]
    
    public init(headerTitle: String? = nil, footerTitle: String? = nil, items: [T]) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.items = items
    }
    
    public static func == (lhs: LookupSession<T>, rhs: LookupSession<T>) -> Bool {
        return lhs.headerTitle == rhs.headerTitle
    }
    
}
