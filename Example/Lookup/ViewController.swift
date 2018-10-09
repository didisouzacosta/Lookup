//
//  ViewController.swift
//  Lookup
//
//  Created by didisouzacosta on 10/02/2018.
//  Copyright (c) 2018 didisouzacosta. All rights reserved.
//

import UIKit
import Lookup

class ViewController: UIViewController {

    private var lookupController: LookupController<String> {
        let lookup = LookupController<String>() { search, dataSource in
            let results = ["Adriano", "Adriano", "Jenifer", "Cida", "Dario", "Getúlio", "Martha"]
            let filtered = !search.term.isEmpty ? results.filter { $0.lowercased().contains(search.term.lowercased()) } : results
            dataSource(.success(filtered))
        }
        lookup.cellIdentifierForRowHandler = { indexPath, item in
            if (indexPath.row % 3) == 0 {
                return .custom("TestCell")
            } else {
                return .default
            }
        }
        lookup.didSelectItemHandler = { item in
            print(item)
        }
        return lookup
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func showSearch() {
        show(lookupController, sender: nil)
    }
    
    @IBAction private func performLookup() {
        showSearch()
    }

}
