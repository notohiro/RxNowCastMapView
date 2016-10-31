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
				let request = RainLevelsModel.Request(coordinate: coordinate, range: 0...0)

				rainLevelsModel.rx.rainLevels(with: request).subscribe(onNext: { result in
					switch result {
					case .succeeded(_, _):
						self.isFinished = true
					default:
						break
					}
				}).addDisposableTo(bag)
			}

		}).addDisposableTo(bag)

		baseTimeModel.fetch()

		wait(seconds: 3)

		XCTAssertTrue(isFinished)
	}
}
