//
//  FavsViewController.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//

import Foundation
import UIKit

class FavsViewController : UIViewController {
    
    var viewModel : FavsViewModel
    
    public init(viewModel : FavsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        configureView()
        configureDataBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
    func configureView() {
        self.view.addSubview(tableView)
        tableView.attachAnchors(to: self.view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.reloadData()
    }
    
    func configureDataBinding() {
        viewModel.isDataLoaded.bind { [weak self] isLoaded in
            guard let self = self else {
                return
            }
            if isLoaded {
                self.tableView.reloadData()
            }
        }
    }
}

extension FavsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        viewModel.configure(cell: cell, for: indexPath)
        return cell
    }
    
}

extension FavsViewController : UITableViewDelegate {
    
    
}
