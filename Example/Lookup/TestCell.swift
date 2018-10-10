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

class TestCell: UITableViewCell, LookupCell {
    
    @IBOutlet private weak var titleLabel: UILabel?
    
    public static var reuseIdentifier: String {
        return "Test2Cell"
    }
    
    func setup<T: LookupItem>(with item: T) {
        titleLabel?.text = item.lookupItemTitle
    }
    
}
