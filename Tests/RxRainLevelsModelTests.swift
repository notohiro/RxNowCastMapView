//
//  RxRainLevelsModelTests.swift
//  RxNowCastMapView
//
//  Created by Hiroshi Noto on 2016/10/31.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import XCTest
import RxSwift
import NowCastMapView
import CoreLocation

@testable import RxNowCastMapView

class RxRainLevelsModelTests: BaseTestCase {
	private var isFinished = false

	override func setUp() {
		super.setUp()

		isFinished = false
	}

	func test() {
		let bag = DisposeBag()

		let baseTimeModel = RxBaseTimeModel()

		baseTimeModel.baseTime.subscribe(onNext: { baseTime in
			if let baseTime = baseTime {
				let rainLevelsModel = RainLevelsModel(baseTime: baseTime)

				let coordinate = CLLocationCoordinate2DMake(35.5758852, 139.6574993)
				let request = RainLevelsModel.Request(coordinate: coordinate, range: -12...12)

				rainLevelsModel.rx.rainLevels(with: request).subscribe(onNext: { result in
					self.isFinished = true
				}).disposed(by: bag)
			}

		}).disposed(by: bag)

		baseTimeModel.fetch()

		wait(seconds: 3)

		XCTAssertTrue(isFinished)
	}

	func testFlatMap() {
		let bag = DisposeBag()

		let baseTimeModel = RxBaseTimeModel()
		let request = Variable<RainLevelsModel.Request?>(nil)

		let rainLevels = Observable
			.combineLatest(baseTimeModel.baseTime, request.asObservable()) { ($0, $1) }
			.flatMapLatest { baseTime, request -> Observable<RainLevels> in
				if let baseTime = baseTime, let request = request {
					let rainLevelsModel = RainLevelsModel(baseTime: baseTime)
					return rainLevelsModel.rx.rainLevels(with: request).debug()
				} else {
					return Observable.never()
				}
			}

		rainLevels
			.subscribe(onNext: { rainLevels in
				self.isFinished = true
			})
			.disposed(by: bag)

		baseTimeModel.fetch()

		let coordinate = CLLocationCoordinate2DMake(35.5758852, 139.6574993)
		request.value = RainLevelsModel.Request(coordinate: coordinate, range: -12...12)

		wait(seconds: 3)

		XCTAssertTrue(isFinished)
	}
}
