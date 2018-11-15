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
    public typealias IdentifierForRowHandler = (T, IndexPath) -> LookupCellType
    public typealias EditActionsHandler = (T, IndexPath) -> [LookupEditActionRepresentable]
    public typealias AcessoryTypeHandler = (T, IndexPath) -> UITableViewCellAccessoryType
    
    // MARK: - Public Variables
    
    public var didSelectItemHandler: ((T) -> Void)? {
        get { return viewModel.didSelectItemHandler }
        set { viewModel.didSelectItemHandler = newValue }
    }
    
    public var organizedItemsHandler: (([T], LookupSearcheable) -> LookupSessionOrganizer<T>)? {
        get { return viewModel.organizedItemsHandler }
        set { viewModel.organizedItemsHandler = newValue }
    }
    
    public var customIdentifierForRowHandler: IdentifierForRowHandler? {
        get { return viewModel.customIdentifierForRowHandler }
        set { viewModel.customIdentifierForRowHandler = newValue }
    }
    
    public var selectedItem: T?
    public var acessoryTypeHandler: AcessoryTypeHandler?
    public var editActionsHandler: EditActionsHandler?
    public var hidesSearchBarWhenScrolling: Bool = false
    public var obscuresBackgroundDuringPresentation: Bool = false
    public var hidesNavigationBarDuringPresentation: Bool = false
    
    // MARK: - Private Variables
    
    private var lookupSearch: LookupSearcheable!
    private var searchHandler: SearchHandler!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = obscuresBackgroundDuringPresentation
        searchController.hidesNavigationBarDuringPresentation = hidesNavigationBarDuringPresentation
        
        var searchBar = searchController.searchBar
        searchBar.placeholder = viewModel.lookupSearch.placeholder
        searchBar.scopeButtonTitles = viewModel.lookupSearch.scopes
        searchBar.selectedScopeButtonIndex = viewModel.lookupSearch.selectedScope ?? 0
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        return searchController
    }()
    
    private lazy var viewModel: LookupViewModelController<T> = {
        let viewModel = LookupViewModelController<T>(lookupSearch: lookupSearch, searchHandler: searchHandler)
        viewModel.updatedContentHandler = { [weak self] in
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
    
    public init(style: UITableView.Style = .plain, title: String? = nil, lookupSearch: LookupSearcheable = LookupSearch(), searchHandler: @escaping SearchHandler) {
        super.init(style: style)
        self.lookupSearch = lookupSearch
        self.searchHandler = searchHandler
        self.title = title
        self.searchController.searchBar.setValue("Cancelar", forKey:"_cancelButtonText")
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
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    // MARK: - Public Methods
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    public override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return (editActionsHandler?(viewModel.item(for: indexPath), indexPath) ?? []).map { $0.rowAction }
    }
    
    public func reloadData() {
        viewModel.reloadData()
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = viewModel.identifier(with: tableView, at: indexPath)
        let reusable = tableView.dequeueReusableCell(withIdentifier: identifier.reuseIdentifier, for: indexPath)
        guard let cell = reusable as? LookupCellRepresentable else { fatalError() }
        let item = viewModel.item(for: indexPath)
        cell.accessoryType = item.lookupItemIgnoreAcessory ? .none : selectedItem == item ? .checkmark : acessoryTypeHandler?(item, indexPath) ?? .none
        cell.setup(with: item)
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(for: section)
    }
    
    public override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return viewModel.footerTitle(for: section)
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
    
    private func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let button = searchBar.value(forKey: "cancelButton") as? UIButton
        button?.setTitle("Cancelar", for: .normal)
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView.register(viewModel.defaultIdentifier.nib, forCellReuseIdentifier: viewModel.defaultIdentifier.reuseIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = viewModel.footerView
    }
    
    private func setupSearch() {
        guard viewModel.lookupSearch.searcheable else { return }
        tableView.tableHeaderView = searchController.searchBar
//        if #available(iOS 11.0, *) {
//            if navigationController?.navigationItem != nil {
//                navigationItem.searchController = searchController
//                navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
////                definesPresentationContext = true
//            } else {
//                tableView.tableHeaderView = searchController.searchBar
//            }
//        } else {
//            tableView.tableHeaderView = searchController.searchBar
//        }
    }
    
}
