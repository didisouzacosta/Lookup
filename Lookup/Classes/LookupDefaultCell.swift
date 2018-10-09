//
//  LookupDefaultCell.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation
import UIKit

public class LookupDefaultCell: UITableViewCell, LookupItemCellRepresentable {
    
    @IBOutlet private var titleLabel: UILabel?
    
    public func setup<T: LookupItem>(with item: T) {
        titleLabel?.text = item.lookupItemTitle
    }
    
}
