//
//  ViewController.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import UIKit

class RestaurantsViewController: UIViewController {
    
    var collectionView : UICollectionView!
    var viewModel : RestaurantsListViewModel
    
    public init(viewModel : RestaurantsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureDataBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    func configureView() {
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
    }
    
    let loadingView : UIAlertController = {
        let alert = UIAlertController(title: nil,
                                      message: "Please wait...",
                                      preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        return alert
    }()
}

extension RestaurantsViewController : UICollectionViewDelegate {
    
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



