//
//  BaseTestCase.swift
//  RxNowCastMapView
//
//  Created by Hiroshi Noto on 2016/10/31.
//  Copyright © 2016 Hiroshi Noto. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase {
	func wait(seconds: TimeInterval) {
		RunLoop.current.run(until: Date(timeIntervalSinceNow: seconds))
	}
}
