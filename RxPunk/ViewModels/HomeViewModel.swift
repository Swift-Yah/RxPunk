//
//  HomeViewModel.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.URL
import class RxSwift.Observable
import class RxSwift.MainScheduler

struct HomeViewModel {
    let result: Observable<DefaultPunkAPI.GetBeersResponse>

    init(loadNextPageTrigger: Observable<Void>, api: DefaultPunkAPI) {
        let url = URL(string: "https://api.punkapi.com/v2/beers?per_page=80")!

        result = loadNextPageTrigger.flatMapLatest({
            return api.getBeers(at: url, nextPageTrigger: loadNextPageTrigger)
        }).observeOn(MainScheduler.instance)
    }
}
