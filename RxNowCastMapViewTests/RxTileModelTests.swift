//
//  RxTileModelTests.swift
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

class RxTileModelTests: BaseTestCase {
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
				let tileModel = RxTileModel(baseTime: baseTime)

				tileModel.added.subscribe(onNext: { tiles in
					self.isFinished = true
				}).addDisposableTo(bag)

				let coordinate = CLLocationCoordinate2DMake(35.5758852, 139.6574993)
				let coordinates = Coordinates(origin: coordinate, terminal: coordinate)

				let request = TileModel.Request(index: 0, scale: 0.000122, coordinates: coordinates)
				let _ = tileModel.tiles(with: request)

				tileModel.resume()
			}

		}).addDisposableTo(bag)

		baseTimeModel.fetch()

		wait(seconds: 3)

		XCTAssertTrue(isFinished)
	}
}
