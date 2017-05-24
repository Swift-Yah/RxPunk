//
//  APIKeys.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

enum APIKeys: String {
    case alcoholLevel = "abv"
    case bitternessScale = "ibu"
    case description
    case imageURL = "image_url"
    case name
    case tagline
}

// MARK: Computed variables

extension APIKeys {
    var $: String {
        return rawValue
    }
}
