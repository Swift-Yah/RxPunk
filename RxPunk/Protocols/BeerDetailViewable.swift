//
//  BeerDetailViewable.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class UIKit.UILabel
import class UIKit.UIViewController

protocol BeerDetailViewable: BeerViewable {
    var taglineLabel: UILabel! { get set }
    var bitternessScaleLabel: UILabel! { get set }
    var descriptionLabel: UILabel! { get set }

    func setupDetail(beer: Beer)
}

// MARK: Default implementation

extension BeerDetailViewable where Self: UIViewController {
    func setupDetail(beer: Beer) {
        beerImageView.kf.setImage(with: beer.imageURL)
        nameLabel.text = beer.name
        alcoholLevelLabel.text = "Alcohol: \(beer.alcoholLevel)"
    }
}
