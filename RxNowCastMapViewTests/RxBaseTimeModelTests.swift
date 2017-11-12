//
//  RxBaseTimeModelTests.swift
//  RxNowCastMapViewTests
//
//  Created by Hiroshi Noto on 2016/10/29.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import XCTest
import RxSwift
import NowCastMapView

@testable import RxNowCastMapView

class RxBaseTimeModelTests: BaseTestCase {
	private var isFinished = false
    
    override func setUp() {
        super.setUp()

		isFinished = false
    }

	func test() {
		let bag = DisposeBag()
		let model = RxBaseTimeModel()

		model.baseTime.subscribe(onNext: { baseTime in
			if baseTime != nil { self.isFinished = true }
		}).disposed(by: bag)

		model.fetch()

		wait(seconds: 3)

		XCTAssertTrue(isFinished)
	}
}
