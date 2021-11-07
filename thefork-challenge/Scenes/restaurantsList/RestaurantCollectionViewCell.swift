//
//  RestaurantCollectionViewCell.swift
//  thefork-challenge
//
//  Created by Fernando Menendez on 05/11/2021.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    public static let cellID = "restaurantCollectionViewCell"
    public static let height = 280.0
    
    private let imageSize = 140.0
    
    var viewModel : RestaurantCellViewModel? {
        didSet {
            updateLabels()
        }
    }
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 5.0
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
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    let addressView : RestaurantInformationView = {
        let rv = RestaurantInformationView()
        rv.image = UIImage(named: "location")
        return rv
    }()
    
    let priceView : RestaurantInformationView = {
        let rv = RestaurantInformationView()
        rv.image = UIImage(named: "cash")
        return rv
    }()
    
    let foodtypeView : RestaurantInformationView = {
        let rv = RestaurantInformationView()
        rv.image = UIImage(named: "food")
        return rv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        // Root StackView
        addSubview(stackView)
        stackView.attachAnchors(to: self, with: UIEdgeInsets(top: 4.0, left: 12.0,
                                                             bottom: 4.0, right: 12.0))
        
        stackView.addArrangedSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        //FoodType
        
        let titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.distribution = .fillProportionally
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(titleStackView)
        titleStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 3.0
        infoStackView.addArrangedSubview(addressView)
        infoStackView.addArrangedSubview(foodtypeView)
        infoStackView.addArrangedSubview(priceView)
        stackView.addArrangedSubview(infoStackView)
    }
    
    func updateLabels() {
        titleLabel.text = viewModel?.name
        ratingLabel.text = viewModel?.rating
        foodtypeView.text = viewModel?.type
        addressView.text = viewModel?.address
        priceView.text = viewModel?.averagePrice
        viewModel?.image.bind { [weak self] image in
            guard let self = self,
                  let image = image else {
                      return
            }
            self.imageView.image = image
        }
    }
}
