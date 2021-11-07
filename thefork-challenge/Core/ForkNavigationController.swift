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
        let greenColor = UIColor(named: "fork-green")
        navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.backgroundColor = greenColor
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = greenColor
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
}
