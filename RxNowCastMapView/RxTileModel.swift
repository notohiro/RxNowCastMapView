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

extension TileModel: ReactiveCompatible { }

extension Reactive where Base: TileModel {
	public func tiles(with request: TileModel.Request) -> Observable<[Tile]> {
		return Observable.create { observer in
			let task = self.base.tiles(with: request) { tiles in
				observer.on(.next(tiles))
				observer.on(.completed)
			}

			task.resume()

			return Disposables.create(with: task.invalidateAndCancel)
		}
	}
}
