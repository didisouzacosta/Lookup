//
//  LookupEditAction.swift
//  Lookup
//
//  Created by Adriano Costa on 12/10/18.
//

import Foundation

public struct LookupEditAction: LookupEditActionRepresentable {
    
    public var editActionTitle: String
    public var editActionStyle: UITableViewRowAction.Style
    public var editActionColor: UIColor?
    public var editActionEnabled: Bool = true
    public var editActionHandler: () -> Void
    
    public init(title: String, style: UITableViewRowAction.Style = .default, color: UIColor? = nil, action: @escaping () -> Void) {
        self.editActionTitle = title
        self.editActionStyle = style
        self.editActionColor = color
        self.editActionHandler = action
    }
    
}
