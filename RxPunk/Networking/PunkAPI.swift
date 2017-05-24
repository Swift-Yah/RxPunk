//
//  PunkAPI.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class RxSwift.Observable

protocol PunkAPI {
    func getBeers(nextPageTrigger: Observable<Void>) -> Observable<[Beer]>
}
