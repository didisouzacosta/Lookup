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
        let lookupSearch = LookupSearch(term: "a")
        let lookup = LookupController<String>(lookupSearch: lookupSearch) { search, searchResult in
            let results = ["Adriano", "Jenifer", "Cida", "Dario", "Getúlio", "Martha"]
            let filtered = search.term != nil ? results.filter { $0.contains(search.term ?? "") } : results
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                searchResult(LookupSearchResult.success(filtered))
            }
        }
        lookup.didSelectedItemHandler = { item in
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
