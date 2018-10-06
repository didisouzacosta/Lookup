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
    
    var offsetFromLoad: Int = 10 {
        didSet { load(page: 1) }
    }
    
    private(set) var items: Dynamic<[T]> = Dynamic<[T]>([])
    private(set) var isLoading: Dynamic<Bool> = Dynamic<Bool>(false)
    private(set) var error: Dynamic<Error?> = Dynamic<Error?>(nil)
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return items.value.count
    }
    
    // MARK: - Private Variables
    
    private var lookupSearch: LookupSearcheable
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
    
    func item(for indexPath: IndexPath) -> T {
        return items.value[indexPath.row]
    }
    
    func load(page: Int) {
        guard page != currentPage, !isLoading.value else { return }
        
        currentPage = page
        error.value = nil
        
        if page == 1 {
            items.value = []
        }
        
        isLoading.value = true
        
        searchHandler(lookupSearch) { [weak self] response in
            switch response {
            case .success(let items):
                self?.items.value += items
            case .failure(let error):
                self?.error.value = error
            }
            
            self?.isLoading.value = false
        }
    }
    
    // MARK: - Private Methods
    
}
