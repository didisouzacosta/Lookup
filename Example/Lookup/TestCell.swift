//
//  TestCell.swift
//  Lookup_Example
//
//  Created by Adriano Costa on 08/10/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Lookup

class TestCell: UITableViewCell, LookupItemCellRepresentable {
    
    @IBOutlet private weak var titleLabel: UILabel?
    
    func setup<T: LookupItem>(with item: T) {
        titleLabel?.text = item.lookupItemTitle
    }
    
}
