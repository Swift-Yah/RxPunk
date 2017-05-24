//
//  PunkBeersState.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct PunkBeersState: Mutable {
    var shouldLoadNextPage: Bool = true
    var beers: Version<[Beer]> = Version([])
    var failure: PunkAPIError? = nil
}

// MARK: Computed variables

extension PunkBeersState {
    var isOffline: Bool {
        guard let failure = failure, case .offline = failure else { return false }

        return true
    }

    var isBadRequest: Bool {
        guard let failure = failure, case .badRequest = failure else { return false }

        return true
    }
}
