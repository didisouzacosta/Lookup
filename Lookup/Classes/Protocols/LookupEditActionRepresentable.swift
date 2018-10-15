//
//  LookupEditActionRepresentable.swift
//  Lookup
//
//  Created by Adriano Costa on 12/10/18.
//

import Foundation

public protocol LookupEditActionRepresentable {
    var editActionTitle: String { get }
    var editActionStyle: UITableViewRowAction.Style { get }
    var editActionColor: UIColor? { get }
    var editActionEnabled: Bool { get }
    var editActionHandler: () -> Void { get }
}

extension LookupEditActionRepresentable {
    
    var rowAction: UITableViewRowAction {
        let rowAction = UITableViewRowAction(style: editActionStyle, title: editActionTitle) { _, _ in
            self.editActionHandler()
        }
        rowAction.backgroundColor = editActionColor
        return rowAction
    }
    
}
