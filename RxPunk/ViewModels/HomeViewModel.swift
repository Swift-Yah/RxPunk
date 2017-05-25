//
//  HomeViewModel.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.URL
import struct RxCocoa.Driver
import class RxSwift.Observable
import RxFeedback

struct HomeViewModel {
    let state: Driver<PunkBeersState>

    struct Input {
        let nextPageTrigger: (Driver<PunkBeersState>) -> Driver<Void>
        let performRequest: (URL) -> Observable<GetBeersResponse>
    }

    init(input: Input, api: PunkAPI) {
        let listPerformerFeedback: (Driver<PunkBeersState>) -> Driver<PunkCommand> = { state in
            return state.map({ (shouldLoadNextPage: $0.shouldLoadNextPage, nextURL: $0.nextURL) })
                .distinctUntilChanged({ $0 == $1 })
                .flatMapLatest({ shouldLoadNextPage, nextURL in
                    guard shouldLoadNextPage, let url = nextURL else { return Driver.empty() }

                    return input.performRequest(url).asDriver(onErrorJustReturn: .failure(PunkAPIError.networkError))
                        .map(PunkCommand.punkReceivedResponseReceived)
                })
        }

        let inputFeedbackLoop: (Driver<PunkBeersState>) -> Driver<PunkCommand> = { state in
            return input.nextPageTrigger(state).map({ _ in PunkCommand.loadMoreItems })
        }

        state = Driver.system(initialState: PunkBeersState.initial, reduce: PunkBeersState.reduce,
                              feedback: listPerformerFeedback, inputFeedbackLoop)
    }
}

func == (lhs: (shouldLoadNextPage: Bool, nextURL: URL?), rhs: (shouldLoadNextPage: Bool, nextURL: URL?)) -> Bool {
    return lhs.shouldLoadNextPage == rhs.shouldLoadNextPage && lhs.nextURL == rhs.nextURL
}
