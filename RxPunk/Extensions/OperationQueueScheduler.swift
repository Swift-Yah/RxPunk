//
//  OperationQueueScheduler.swift
//  RxPunk
//
//  Created by Rafael Ferreira on 5/24/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import class Foundation.OperationQueue
import class RxSwift.OperationQueueScheduler

extension OperationQueueScheduler {
    convenience init(maxConcurrentOperationCount: Int) {
        let operationQueue = OperationQueue(maxConcurrentOperationCount: maxConcurrentOperationCount)

        self.init(operationQueue: operationQueue)
    }
}
