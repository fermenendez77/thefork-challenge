//
//  UIView+ConstraintAnchors.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import Foundation
import UIKit
extension UIView {
    
    func attachAnchors(to view: UIView, with insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left)
        ])
    }
}
