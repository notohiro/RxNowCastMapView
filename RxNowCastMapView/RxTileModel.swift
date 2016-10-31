//
//  RxTileModel.swift
//  RxNowCastMapView
//
//  Created by Hiroshi Noto on 2016/10/29.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import Foundation
import RxSwift
import NowCastMapView

open class RxTileModel: TileModel {
	open let added: Observable<Set<Tile>>
	open let failed: Observable<Tile>
	fileprivate let addedSubject = PublishSubject<Set<Tile>>()
	fileprivate let failedSubject = PublishSubject<Tile>()

	override public init(baseTime: BaseTime) {
		added = addedSubject.asObservable()
		failed = failedSubject.asObservable()

		super.init(baseTime: baseTime)

		delegate = self
	}
}

extension RxTileModel: TileModelDelegate {
	public func tileModel(_ model: TileModel, added tiles: Set<Tile>) {
		addedSubject.on(.next(tiles))
	}

	public func tileModel(_ model: TileModel, failed tile: Tile) {
		failedSubject.on(.next(tile))
	}
}
