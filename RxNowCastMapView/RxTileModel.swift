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
	fileprivate let addedSubject = PublishSubject<Set<Tile>>()

	open let failed: Observable<Tile>
	fileprivate let failedSubject = PublishSubject<Tile>()

	open let processing: Observable<Set<Tile>>
	fileprivate let processingSubject = PublishSubject<Set<Tile>>()

	override open var processingTiles: Set<Tile> {
		didSet {
			processingSubject.on(.next(processingTiles))
		}
	}

	override public init(baseTime: BaseTime) {
		added = addedSubject.asObservable()
		failed = failedSubject.asObservable()
		processing = processingSubject.asObservable().shareReplayLatestWhileConnected()

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
