//
//  LookupController.swift
//  Lookup
//
//  Created by Adriano Costa on 02/10/18.
//  Copyright © 2018 Cleander. All rights reserved.
//

import Foundation
import UIKit

public class LookupController<T: LookupItem>: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    public typealias LookupCellRepresentable = LookupCell & UITableViewCell
    public typealias SearchHandler = (_ search: LookupSearcheable, @escaping (_ dataSource: LookupSearchResult<T>) -> Void) -> Void
    public typealias IdentifierHandler = (IndexPath, T) -> LookupCellType
    
    // MARK: - Public Variables
    
    public var didSelectItemHandler: ((T) -> Void)?
    
    public var identifierHandler: IdentifierHandler? {
        get { return viewModel.identifierHandler }
        set { viewModel.identifierHandler = newValue }
    }
    
    public var hidesSearchBarWhenScrolling: Bool = false
    public var obscuresBackgroundDuringPresentation: Bool = false
    
    // MARK: - Private Variables
    
    private var lookupSearch: LookupSearcheable!
    private var searchHandler: SearchHandler!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = obscuresBackgroundDuringPresentation
        searchController.searchBar.placeholder = viewModel.lookupSearch.placeholder
        searchController.searchBar.scopeButtonTitles = viewModel.lookupSearch.scopes
        searchController.searchBar.selectedScopeButtonIndex = viewModel.lookupSearch.selectedScope ?? 0
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private lazy var viewModel: LookupViewModelController<T> = {
        let viewModel = LookupViewModelController<T>(lookupSearch: lookupSearch, searchHandler: searchHandler)
        viewModel.items.bind() { [weak self] _ in
            self?.tableView.reloadData()
        }
        viewModel.isLoading.bind() { [weak self] isLoading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        }
        viewModel.error.bind() { [weak self] error in
            
        }
        return viewModel
    }()
    
    // MARK: - Life Cycle
    
    public init(style: UITableView.Style = .plain, lookupSearch: LookupSearcheable = LookupSearch(), searchHandler: @escaping SearchHandler) {
        super.init(style: style)
        self.lookupSearch = lookupSearch
        self.searchHandler = searchHandler
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearch()
        viewModel.fetch()
    }
    
    // MARK: - Public Methods
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = viewModel.identifier(with: tableView, at: indexPath)
        let reusable = tableView.dequeueReusableCell(withIdentifier: identifier.reuseIdentifier, for: indexPath)
        guard let cell = reusable as? LookupCellRepresentable else { fatalError() }
        cell.setup(with: viewModel.item(for: indexPath))
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectItemHandler?(viewModel.item(for: indexPath))
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        viewModel.fetch(term: searchBar.text ?? "", scopeIndex: searchBar.selectedScopeButtonIndex)
    }
    
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel.fetch(term: searchBar.text ?? "", scopeIndex: selectedScope)
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView.register(viewModel.defaultIdentifier.nib, forCellReuseIdentifier: viewModel.defaultIdentifier.reuseIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupSearch() {
        guard viewModel.lookupSearch.searcheable else { return }
        
        if #available(iOS 11.0, *) {
            if navigationController?.navigationItem != nil {
                navigationItem.searchController = searchController
                navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
                definesPresentationContext = true
            } else {
                tableView.tableHeaderView = searchController.searchBar
            }
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
}