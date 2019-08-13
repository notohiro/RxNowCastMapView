//
//  RxRainLevelsModel.swift
//  RxNowCastMapView
//
//  Created by Hiroshi Noto on 2016/10/28.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import Foundation
import NowCastMapView
import RxSwift

extension RainLevelsModel: ReactiveCompatible { }

/// Reactive extension for RainLevelsModel
public extension Reactive where Base: RainLevelsModel {
    /// Observable sequence of responses for RainLevelsModel request.
    /// Performing of request starts after observer is subscribed and not after invoking this method.
    /// - Parameter request: RainLevelsModel request.
    func rainLevels(with request: RainLevelsModel.Request) -> Observable<RainLevels> {
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
			} catch {
				observer.onError(error)
				return Disposables.create()
			}
		}
	}
}
