//
//  LookupSearchResult.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation

public enum LookupSearchResult<T: LookupItem> {
    case success([T])
    case failure(Error)
}
