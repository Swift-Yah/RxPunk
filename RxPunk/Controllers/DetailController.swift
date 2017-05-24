//
//  DetailController.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class UIKit.UIImageView
import class UIKit.UILabel
import class UIKit.UIViewController

final class DetailController: UIViewController, BeerDetailViewable {
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var alcoholLevelLabel: UILabel!
    @IBOutlet weak var bitternessScaleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: File private variables
    
    fileprivate var beer: Beer? = nil
}

// MARK: Functions

extension DetailController {
    func set(beer: Beer) {
        self.beer = beer
    }
}

// MARK: UIViewControllers functions

extension DetailController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

// MARK: Private functions

private extension DetailController {
    func setupUI() {
        guard let beer = beer else { return }
        
        setup(beer: beer)
        setupDetail(beer: beer)
    }
}
