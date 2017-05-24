//
//  BeerDetailViewable.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class UIKit.UILabel
import class UIKit.UITextView
import class UIKit.UIViewController

protocol BeerDetailViewable: BeerViewable {
    var taglineLabel: UILabel! { get set }
    var bitternessScaleLabel: UILabel! { get set }
    var descriptionTextView: UITextView! { get set }

    func setupDetail(beer: Beer)
}

// MARK: Default implementation

extension BeerDetailViewable where Self: UIViewController {
    func setupDetail(beer: Beer) {
        title = beer.name
        taglineLabel.text = beer.tagline
        bitternessScaleLabel.text = "Bitterness Scale: \(beer.bitternessScale)"
        descriptionTextView.text = beer.description
    }
}
