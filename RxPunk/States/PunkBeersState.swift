//
//  PunkBeersState.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.URL

struct PunkBeersState: Mutable {
    var page: Int
    var shouldLoadNextPage: Bool
    var beers: Version<[Beer]>
    var nextURL: URL?
    var failure: PunkAPIError?

    init(page: Int) {
        self.page = page
        self.shouldLoadNextPage = true
        self.beers = Version([])
        self.nextURL = APIKeys.getBeers(page)
        self.failure = nil
    }
}

// MARK: Static elements

extension PunkBeersState {
    static let initial = PunkBeersState(page: 1)

    static func reduce(state: PunkBeersState, command: PunkCommand) -> PunkBeersState {
        switch command {
        case .punkReceivedResponseReceived(let result):
            switch result {
            case let .success((beers, hasNext)):
                return state.mutate(transform: {
                    $0.page += 1
                    $0.shouldLoadNextPage = false
                    $0.beers = Version($0.beers.value + beers)
                    $0.nextURL = hasNext ? APIKeys.getBeers($0.page) : nil
                    $0.failure = nil
                })
            case let .failure(error):
                return state.mutateOne(transform: { $0.failure = error })
            }

        case .loadMoreItems:
            return state.mutate(transform: {
                if $0.failure == nil {
                    $0.shouldLoadNextPage = true
                }
            })
        }
    }
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
