//
//  LoadingView.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 06/11/2021.
//

import Foundation
import UIKit

class LoadingView : UIAlertController {
    
    override func viewDidLoad() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10,
                                                                     y: 5,
                                                                     width: 50,
                                                                     height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
    }
}
