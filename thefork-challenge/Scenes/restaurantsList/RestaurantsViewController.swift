//
//  ViewController.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import UIKit

class RestaurantsViewController: UIViewController {
    
    var viewModel : RestaurantsListViewModel
    
    var collectionView : UICollectionView!
    let loadingView : UIAlertController = LoadingView(title: nil,
                                                      message: "Loading...",
                                                      preferredStyle: .alert)
    lazy var sortActionSheet : UIAlertController = {
        let alertController = UIAlertController(title: "Sort",
                                                message: "Select an Option",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sort by Name",
                                                style: .default,
                                                handler: { [weak self] _ in
            self?.viewModel.sort(by: .name)
        }))
        alertController.addAction(UIAlertAction(title: "Sort by Rating",
                                                style: .default,
                                                handler: { [weak self] _ in
            self?.viewModel.sort(by: .rating)
        }))
        alertController.addAction(UIAlertAction(title: "Dismiss",
                                                style: .cancel))
        
        return alertController
    }()
    
    public init(viewModel : RestaurantsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureDataBinding()
        viewModel.fetchData()
    }
    
    func configureDataBinding() {
        viewModel.isDataLoaded.bind { [weak self] isLoaded in
            guard let self = self else {
                return
            }
            
            if isLoaded {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else {
                return
            }
            if isLoading {
                self.present(self.loadingView, animated: true)
            } else {
                self.loadingView.dismiss(animated: true)
            }
        }
    }
    
    private func configureViews() {
        // CollectionView
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.bounds,
                                          collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.attachAnchors(to: self.view)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RestaurantCollectionViewCell.self,
                                forCellWithReuseIdentifier: RestaurantCollectionViewCell.cellID)
        
        // NavigationBar
        self.title = "Restaurants"
        let filter = UIBarButtonItem(image: UIImage(named: "solid-heart"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(favsButtonTapped))
        
        let favs = UIBarButtonItem(image: UIImage(named: "sort"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(sortButtonTapped))
        
        navigationItem.rightBarButtonItems = [filter, favs]
    }
    
    @objc func sortButtonTapped() {
        self.present(sortActionSheet, animated: true)
    }
    
    @objc func favsButtonTapped() {
        let favsVC = FavsViewController(viewModel: FavsViewModel())
        self.navigationController?.pushViewController(favsVC, animated: true)
    }
}

// MARK: CollectionView Delegate and Datarsource methods
extension RestaurantsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.cellID,
                                 for: indexPath) as! RestaurantCollectionViewCell
        cell.cleanCell()
    }
}

extension RestaurantsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width,
                      height: RestaurantCollectionViewCell.height)
    }
}

extension RestaurantsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: RestaurantCollectionViewCell.cellID,
                                 for: indexPath) as! RestaurantCollectionViewCell
        cell.viewModel = viewModel.viewModelCell(for: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataCount
    }
}
