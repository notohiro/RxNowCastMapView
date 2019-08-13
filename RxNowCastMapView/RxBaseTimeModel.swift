//
//  RxBaseTimeModel.swift
//  RxNowCastMapView
//
//  Created by Hiroshi Noto on 2016/10/25.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import Foundation

import RxRelay
import RxSwift

import NowCastMapView

open class RxBaseTimeModel: BaseTimeModel {
    public let baseTime: Observable<BaseTime?>
    internal let baseTimeVar = BehaviorRelay<BaseTime?>(value: nil)

	override public init() {
		baseTime = baseTimeVar.asObservable()

		super.init()

		delegate = self
	}

    deinit { }
}

extension RxBaseTimeModel: BaseTimeModelDelegate {
	public func baseTimeModel(_ model: BaseTimeModel, fetched baseTime: BaseTime?) {
        baseTimeVar.accept(baseTime)
	}
}
