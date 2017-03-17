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

extension RainLevelsModel {
	public enum Error: Swift.Error {
		/// Unknown error occurred.
		case unknown(request: Request)
		/// Canceled
		case canceled(request: Request)
	}
}

extension RainLevelsModel: ReactiveCompatible { }

extension Reactive where Base: RainLevelsModel {
	public func rainLevels(with request: RainLevelsModel.Request) -> Observable<RainLevelsModel.Result> {
		return Observable.create { observer in
			let _ = self.base.rainLevels(with: request) { result in
				switch result {
				case .succeeded(_, _):
					observer.on(.next(result))
					observer.on(.completed)
				case let .canceled(request):
					observer.on(.error(RainLevelsModel.Error.canceled(request: request)))
				case let .failed(request):
					observer.on(.error(RainLevelsModel.Error.unknown(request: request)))
				}
			}

			return Disposables.create() { self.base.cancel(request) }
		}
	}
}
