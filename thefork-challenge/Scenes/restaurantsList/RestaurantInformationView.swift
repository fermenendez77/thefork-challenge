//
//  RestaurantInformationView.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 07/11/2021.
//

import Foundation
import UIKit

class RestaurantInformationView : UIView {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .leading
        sv.spacing = 5.0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0,
                                                  width: 24, height: 24))
        imageView.layer.cornerRadius = 6.0
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor(named: "light-green")
        return imageView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    var image : UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var text : String? {
        didSet {
            label.text = text
        }
    }
    
    private func configureView() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor,
                                           constant: 0.0).isActive = true
        stackView.addArrangedSubview(label)
        label.centerYAnchor.constraint(equalTo: stackView.centerYAnchor,
                                       constant: 0.0).isActive = true
    }
}
