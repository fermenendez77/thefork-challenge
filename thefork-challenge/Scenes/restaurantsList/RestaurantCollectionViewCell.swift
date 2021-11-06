//
//  RestaurantCollectionViewCell.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    public static let cellID = "restaurantCollectionViewCell"
    public static let height = 240.0
    
    var viewModel : RestaurantCellViewModel? {
        didSet {
            updateLabels()
        }
    }
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()


    let imageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.layer.cornerRadius = 6.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21.0)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let ratingLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21.0)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    let foodTypeLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    let averagePriceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    override func layoutSubviews() {
        // Root StackView
        self.backgroundColor = .systemTeal
        addSubview(stackView)
        stackView.attachAnchors(to: self, with: UIEdgeInsets(top: 4.0, left: 12.0,
                                                             bottom: 4.0, right: 12.0))
        
        //Image
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: self.layer.bounds.width,
                                 height: 90.0)
        stackView.addArrangedSubview(imageView)
        
        //FoodType
        stackView.addArrangedSubview(foodTypeLabel)
        
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.distribution = .fillProportionally
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(titleStackView)
        titleStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(averagePriceLabel)
        
        viewModel?.image.bind { [weak self] image in
            guard let self = self,
                  let image = image else {
                      return
            }
            self.imageView.image = image
        }
    }
    
    func updateLabels() {
//        imageView.image = UIImage(named: "food-example")
        titleLabel.text = viewModel?.name
        ratingLabel.text = viewModel?.rating
        foodTypeLabel.text = viewModel?.type
        addressLabel.text = viewModel?.address
        averagePriceLabel.text = viewModel?.averagePrice
    }
}
