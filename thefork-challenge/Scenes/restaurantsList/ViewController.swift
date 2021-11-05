//
//  ViewController.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    func configureView() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.bounds,
                                          collectionViewLayout: flowLayout)
        self.view.addSubview(collectionView)
        collectionView.attachAnchors(to: self.view)
        collectionView.backgroundColor = .blue
    }
}

