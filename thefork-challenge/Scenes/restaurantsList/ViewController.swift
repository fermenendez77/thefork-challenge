//
//  ViewController.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView : UICollectionView!
    var viewModel = RestaurantsListViewModel()
    
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
        viewModel.restaurants.bind { [weak self] _ in
            self?.collectionView.reloadData()
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
        self.view.addSubview(collectionView)
        collectionView.attachAnchors(to: self.view)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
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

extension ViewController : UICollectionViewDelegate {
    
    
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 70.0)
    }
}

extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = .green
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataCount
    }
}



