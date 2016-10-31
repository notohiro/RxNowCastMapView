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
	public func rainLevels(with request: RainLevelsModel.Request) -> Observable<RainLevelsModel.Result> {
		return Observable.create { observer in
			let _ = self.base.rainLevels(with: request) { result in
				observer.on(.next(result))

				switch result {
				case .succeeded(_, _):
					observer.on(.completed)
				case .canceled(_):
					observer.on(.error(RxNowCastMapViewError.canceled))
				case .failed(_):
					observer.on(.error(RxNowCastMapViewError.unknown))
				}
			}

			return Disposables.create() { self.base.cancel(request) }
		}
	}
}
