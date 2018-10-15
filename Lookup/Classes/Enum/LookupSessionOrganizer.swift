//
//  LookupSessionOrganizer.swift
//  Lookup
//
//  Created by Adriano Costa on 14/10/18.
//

import Foundation

public enum LookupSessionOrganizer<T: LookupItem> {
    case `default`
    case alphabetic
    case custom([LookupSession<T>])
}
