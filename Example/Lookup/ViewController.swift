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
        let lookupSearch = LookupSearch(scopes: ["Nome", "Apelido"], selectedScope: 1, placeholder: "Pesquisar")
        let lookup = LookupController<String>(lookupSearch: lookupSearch) { search, searchResult in
            let results = ["Adriano", "Adriano", "Jenifer", "Cida", "Dario", "Getúlio", "Martha"]
            let filtered = !search.term.isEmpty ? results.filter { $0.lowercased().contains(search.term.lowercased()) } : results
            searchResult(.success(filtered))
        }
//        lookup.cellIdentifierForRowHandler = { indexPath, item in
//            if (indexPath.row % 3) == 0 {
//                return .custom(LookupCellIdentifier("TestCell"))
//            } else {
//                return .default
//            }
//        }
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
