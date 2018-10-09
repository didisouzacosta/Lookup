//
//  LookupViewModelController.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

import Foundation

final class LookupViewModelController<T: LookupItem> {
    
    typealias SearchHandler = (_ search: LookupSearcheable, @escaping (_ result: LookupSearchResult<T>) -> Void) -> Void
    
    // MARK: - Public Variables
    
    public var searcheable: Bool = true
    
    private(set) var lookupSearch: LookupSearcheable
    
    private(set) var items: Dynamic<[T]> = Dynamic<[T]>([])
    private(set) var isLoading: Dynamic<Bool> = Dynamic<Bool>(false)
    private(set) var error: Dynamic<Error?> = Dynamic<Error?>(nil)
    
    var registeredCells: [LookupItemIdentifiable] = []
    
    var offset: Int {
        return lookupSearch.offset
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return items.value.count
    }
    
    // MARK: - Private Variables
    
    private var searchHandler: SearchHandler
    
    private var currentPage: Int = 0 {
        didSet { lookupSearch.page = currentPage }
    }
    
    // MARK: - Life Cycle
    
    init(lookupSearch: LookupSearcheable, searchHandler: @escaping SearchHandler) {
        self.lookupSearch = lookupSearch
        self.searchHandler = searchHandler
    }
    
    // MARK: - Public Methods
    
    func fetch(with page: Int = 1, term: String = "", scopeIndex: Int? = nil) {
        lookupSearch.page = page
        lookupSearch.term = term
        lookupSearch.selectedScope = scopeIndex
        fetch()
    }
    
    func item(for indexPath: IndexPath) -> T {
        return items.value[indexPath.row]
    }
    
    // MARK: - Private Methods
    
    private func fetch() {
        let currentPage = lookupSearch.page
        let currentTerm = lookupSearch.term
        let currentScope = lookupSearch.selectedScope
        
        error.value = nil
        isLoading.value = true
        
        if currentPage == 1 {
            items.value = []
        }
        
        searchHandler(lookupSearch) { [weak self] response in
            guard self?.lookupSearch.page == currentPage,
                self?.lookupSearch.term == currentTerm,
                self?.lookupSearch.selectedScope == currentScope else { return }
            
            self?.isLoading.value = false
            
            switch response {
            case .success(let items):
                self?.items.value += items
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
}
