//
//  RxBaseTimeModel.swift
//  RxNowCastMapView
//
//  Created by Hiroshi Noto on 2016/10/25.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import Foundation
import RxSwift
import NowCastMapView

open class RxBaseTimeModel: BaseTimeModel {
	open let baseTime: Observable<BaseTime?>
	fileprivate let baseTimeVar = Variable<BaseTime?>(nil)

	override public init() {
		baseTime = baseTimeVar.asObservable()

		super.init()

		delegate = self
	}
}

extension RxBaseTimeModel: BaseTimeModelDelegate {
	public func baseTimeModel(_ model: BaseTimeModel, fetched baseTime: BaseTime?) {
		baseTimeVar.value = baseTime
	}
}
