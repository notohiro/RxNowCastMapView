//
//  RxRainLevelsModel.swift
//  RxNowCastMapView
//
//  Created by Hiroshi Noto on 2016/10/28.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import Foundation
import RxSwift
import NowCastMapView

extension RainLevelsModel: ReactiveCompatible { }

extension Reactive where Base: RainLevelsModel {
	public func rainLevels(with request: RainLevelsModel.Request) -> Observable<RainLevels> {
		return Observable.create { observer in
			do {
				let task = try self.base.rainLevels(with: request) { result in
					switch result {
					case let .succeeded(_, rainLevels):
						observer.onNext(rainLevels)
						observer.onCompleted()
					case let .failed(_, error):
						observer.onError(error)
					}
				}

				task.resume()

				return Disposables.create(with: task.cancel)
			} catch let error {
				observer.onError(error)
				return Disposables.create()
			}
		}
	}
}
