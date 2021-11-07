//
//  ForkNavigationController.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 06/11/2021.
//

import Foundation
import UIKit

class ForkNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.backgroundColor = UIColor(named: "fork-green")
    }
}
