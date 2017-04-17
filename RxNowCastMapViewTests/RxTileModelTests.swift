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

		let coordinate = CLLocationCoordinate2DMake(35.5758852, 139.6574993)
		let coordinates = Coordinates(origin: coordinate, terminal: coordinate)
		let request = TileModel.Request(index: 0, scale: 0.000122, coordinates: coordinates)

		let tileModel = baseTimeModel.baseTime
			.map { baseTime -> RxTileModel? in
				guard let baseTime = baseTime else { return nil }
				return RxTileModel(baseTime: baseTime)
			}.shareReplayLatestWhileConnected()

		tileModel
			.filter { $0 != nil }
			.take(1)
			.subscribe(onNext: { tileModel in
				guard let tileModel = tileModel else { return }
				let _ = tileModel.tiles(with: request)
				tileModel.resume()
				print("requested")
			})
			.addDisposableTo(bag)

		tileModel
			.flatMapLatest { tileModel -> Observable<Set<Tile>> in
				guard let tileModel = tileModel else { return Observable.never() }
				return tileModel.added
			}
			.subscribe(onNext: { [weak self] _ in
				self?.isFinished = true
			})
			.addDisposableTo(bag)

		tileModel
			.flatMapLatest { tileModel -> Observable<Set<Tile>> in
				guard let tileModel = tileModel else { return Observable.never() }
				return tileModel.processing
			}
			.subscribe(onNext: { processing in
				print(processing.count)
			})
			.addDisposableTo(bag)

		baseTimeModel.fetch()

		wait(seconds: 3)

		XCTAssertTrue(isFinished)
	}
}
