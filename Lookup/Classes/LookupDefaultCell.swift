//
//  LookupDefaultCell.swift
//  Lookup
//
//  Created by Adriano Costa on 06/10/18.
//

import Foundation
import UIKit

public class LookupDefaultCell: UITableViewCell, LookupItemCell {
    
    @IBOutlet private var titleLabel: UILabel?
    
    public static var lookupCellIdentifier: String {
        return "LookupDefaultCell"
    }
    
    public static var lookupCellNib: UINib {
        return UINib(nibName: "LookupDefaultCell", bundle: Bundle(for: LookupDefaultCell.self))
    }
    
    public func setup(with item: LookupItem) {
        titleLabel?.text = item.lookupItemTitle
    }
    
}
