//
//  LookupViewModelController.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

import Foundation

final class LookupViewModelController<T: LookupItem> {
    
    typealias SearchHandler = (_ search: LookupSearcheable, @escaping (_ dataSource: LookupSearchResult<T>) -> Void) -> Void
    
    // MARK: - Public Variables
    
    var customIdentifierForRowHandler: ((T, IndexPath) -> LookupCellType)?
    var organizedItemsHandler: (([T], LookupSearcheable) -> LookupSessionOrganizer<T>)?
    var didSelectItemHandler: ((T) -> Void)?
    var updatedContentHandler: (() -> Void)?
    
    private(set) var lookupSearch: LookupSearcheable
    private(set) var isLoading: Dynamic<Bool> = Dynamic<Bool>(false)
    private(set) var error: Dynamic<Error?> = Dynamic<Error?>(nil)
    
    var offset: Int {
        return lookupSearch.offset
    }
    
    var defaultIdentifier: LookupIdentifiable {
        return LookupDefaultIdentifier()
    }
    
    var numberOfSections: Int {
        return organizedItems.count
    }
    
    var footerView: UITableViewHeaderFooterView {
        return UITableViewHeaderFooterView()
    }
    
    // MARK: - Private Variables
    
    private var searchHandler: SearchHandler
    private var identifiers: [LookupIdentifiable] = []
    
    private var items: [T] = [] {
        didSet {
            if let organizer = organizedItemsHandler?(items, lookupSearch) {
                switch organizer {
                case .default:
                    organizedItems = [LookupSession(items: items)]
                case .alphabetic:
                    var sections: [LookupSession<T>] = []
                    
                    items.forEach { item in
                        guard let title = item.lookupItemTitle, !title.isEmpty else { return }
                        
                        let firstChar = "\(title.prefix(1))"
                        
                        if let section = sections.first(where: { $0.headerTitle?.lowercased() == firstChar.lowercased() }) {
                            section.items.append(item)
                        } else {
                            sections.append(LookupSession(headerTitle: firstChar, items: [item]))
                        }
                    }
                    
                    organizedItems = sections
                case .custom(let sections):
                    sections.forEach { lookupSection in
                        let items = lookupSection.items
                        
                        if let section = organizedItems.first(where: { section -> Bool in
                            return section == lookupSection
                        }) {
                            section.items += items
                        } else {
                            organizedItems.append(lookupSection)
                        }
                    }
                }
            } else {
                organizedItems = [LookupSession(items: items)]
            }
        }
    }
    
    private var organizedItems: [LookupSession<T>] = [] {
        didSet {
            updatedContentHandler?()
        }
    }
    
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
        loadData()
    }
    
    func item(for indexPath: IndexPath) -> T {
        return organizedItems[indexPath.section].items[indexPath.row]
    }
    
    func headerTitle(for section: Int) -> String? {
        return organizedItems[section].headerTitle
    }
    
    func footerTitle(for section: Int) -> String? {
        return organizedItems[section].footerTitle
    }
    
    func numberOfRows(at section: Int) -> Int {
        return organizedItems[section].items.count
    }
    
    func reloadData() {
        lookupSearch.page = 1
        loadData()
    }
    
    func identifier(with tableView: UITableView, at indexPath: IndexPath) -> LookupIdentifiable {
        guard let itemType = customIdentifierForRowHandler?(item(for: indexPath), indexPath) else {
            return defaultIdentifier
        }
        
        switch itemType {
        case .custom(let identifier):
            if register(identifier: identifier) {
                tableView.register(identifier.nib, forCellReuseIdentifier: identifier.reuseIdentifier)
            }
            return identifier
        default:
            return defaultIdentifier
        }
    }
    
    func register(identifier: LookupIdentifiable) -> Bool {
        guard !identifiers.contains(where: { return $0.reuseIdentifier == identifier.reuseIdentifier }) else { return false }
        identifiers.append(identifier)
        return true
    }
    
    // MARK: - Private Methods
    
    private func loadData() {
        let currentPage = lookupSearch.page
        let currentTerm = lookupSearch.term
        let currentScope = lookupSearch.selectedScope
        
        error.value = nil
        isLoading.value = true
        
        if currentPage == 1 {
            items = []
        }
        
        searchHandler(lookupSearch) { [weak self] response in
            guard self?.lookupSearch.page == currentPage,
                self?.lookupSearch.term == currentTerm,
                self?.lookupSearch.selectedScope == currentScope else { return }
            
            self?.isLoading.value = false
            
            switch response {
            case .success(let items):
                self?.items += items
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
    
}
