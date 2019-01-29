//
//  RepoViewController.swift
//  RealmDbRelationship
//
//  Created by Rifat Firdaus on 10/3/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit
import SVPullToRefresh
import TPKeyboardAvoiding

class RepoViewController: UIViewController {

    var tableView: TPKeyboardAvoidingTableView!
    var presenter = RepoPresenter()
    
    var searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    
    static func instantiate() -> RepoViewController {
        let controller = UIStoryboard.sample.instantiateViewController(withIdentifier: self.className()) as! RepoViewController
        return controller
    }
    
    static func instantiateNav() -> UINavigationController {
        let controller = UIStoryboard.sample.instantiateViewController(withIdentifier: self.className()) as! RepoViewController
        let nav = ViewManager.createNavigationController(rootController: controller, transparent: false)
        return nav
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Repositories"
        tableView = SMContainerView.createTableView(viewParent: self.view)
        presenter.view = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.parent?.title = "Repositories"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let searchText = self.searchController.searchBar.text {
            if self.presenter.data.count == 0 {
                self.refresh(searchText: searchText)
            }
        }
    }

    @objc func searchText(sender: Any?) {
        if self.searchController.searchBar.text != nil && self.searchController.searchBar.text != "" {
            self.refresh(searchText: self.searchController.searchBar.text ?? "scotteg")
        }
    }
    
    func setupTableView() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.text = "scotteg"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepoCell.loadNib(), forCellReuseIdentifier: RepoCell.className())
        tableView.addPullToRefresh { [weak self] in
            if let searchText = self?.searchController.searchBar.text, self?.searchController.searchBar.text != "" {
                self?.refresh(searchText: searchText)
            } else {
                self?.tableView.pullToRefreshView.stopAnimating()
            }
        }
        tableView.addInfiniteScrolling { [weak self] in
            if let searchText = self?.searchController.searchBar.text, self?.searchController.searchBar.text != "" {
                self?.presenter.next(user: searchText)
            } else {
                self?.tableView.infiniteScrollingView.stopAnimating()
            }
        }
        
        // remove underlines_navbar and searchBar_border
        //
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.backgroundColor = SMUITheme.primaryColor
        searchController.searchBar.barTintColor = SMUITheme.primaryColor
        self.parent?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.parent?.navigationController?.navigationBar.shadowImage = UIImage()
        self.parent?.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func refresh(searchText: String) {
        self.tableView.pullToRefreshView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.presenter.refresh(user: searchText)
        }
    }
}

extension RepoViewController: RepoPresenterProtocol {
    func showData() {
        if self.presenter.data.count == 0 {
            self.parent?.tabBarItem.badgeValue = nil
            self.tableView.infiniteScrollingView.enabled = false
        } else {
            self.tabBarItem.badgeValue = "\(self.presenter.data.count)"
            let tabbarController = self.parent as? SMTabBarController
            let newsTabbar = tabbarController?.tabBar.items?[1]
            newsTabbar?.badgeValue = "1"
            self.tableView.infiniteScrollingView.enabled = true
        }
        tableView.pullToRefreshView.stopAnimating()
        tableView.infiniteScrollingView.stopAnimating()
        tableView.reloadData()
    }
    
    func showError(error: Error?) {
        tableView.pullToRefreshView.stopAnimating()
    }
}

extension RepoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.className(), for: indexPath) as! RepoCell
        if indexPath.row < presenter.data.count {
            cell.repo = presenter.data[indexPath.row]
        }
        return cell
    }
    
    // delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = RepoLinkDetailViewController.instantiate(repo: presenter.data[indexPath.row])
        pushController(controller: controller, withbackTitle: " ", animated: true, color: .white)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchController.searchBar
    }
}

extension RepoViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchText(sender:)), userInfo: nil, repeats: false)
    }
}
