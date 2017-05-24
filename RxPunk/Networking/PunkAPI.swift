//
//  PunkAPI.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.URL
import class RxSwift.Observable

protocol PunkAPI {
    associatedtype GetBeersResponse
    
    func getBeers(at: URL, nextPageTrigger: Observable<Void>) -> Observable<GetBeersResponse>
}
