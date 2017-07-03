# RxNowCastMapView

[![Swift](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)](https://swift.org)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/RxNowCastMapView.svg)](https://img.shields.io/cocoapods/v/RxNowCastMapView.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/NowCastMapView.svg?style=flat)](http://cocoapods.org/pods/RxNowCastMapView)
![license](https://cocoapod-badges.herokuapp.com/l/URWeatherView/badge.png)
[![Twitter](https://img.shields.io/badge/twitter-@notohiro-blue.svg?style=flat)](http://twitter.com/notohiro)

RxNowCastMapView is an Reactive Extension for [NowCastMapView](https://github.com/notohiro/NowCastMapView).

## Installation

RxNowCastMapView is available through [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

## Usage

### RxBaseTimeModel

RxBaseTimeModel never throws .onError and .onCompleted.

```Swift
let model = RxBaseTimeModel()

model.baseTime.subscribe(onNext: { baseTime in
  /// fetched!!!
}).addDisposableTo(bag)

model.fetch()
```

### RainLevelsModel.rx

```Swift
let rainLevelsModel = RainLevelsModel(baseTime: baseTime)

rainLevelsModel.rx.rainLevels(with: request).subscribe(onNext: { result in
	switch result {
	case .succeeded(_, _):
		// process RainLevels
	default:
		break
	}
}).addDisposableTo(bag)
```

## License

RxNowCastMapView is available under the MIT license. See the LICENSE file for more info.
