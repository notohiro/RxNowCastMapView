Pod::Spec.new do |s|
  s.name             = "RxNowCastMapView"
  s.version          = "4.2.0"
  s.summary          = "Reactive Extension for NowCastMapView"
  s.homepage         = "https://github.com/notohiro/RxNowCastMapView"
  s.license          = 'MIT'
  s.author           = { "Hiroshi Noto" => "notohiro@gmail.com" }
  s.source           = { :git => "https://github.com/notohiro/RxNowCastMapView.git", :tag => s.version.to_s }

  s.platform         = :ios, '8.0'
  s.swift_version    = '4.2.0'

  s.requires_arc     = true
  s.source_files     = 'RxNowCastMapView/*'
  s.dependency         'RxSwift'
  s.dependency         'NowCastMapView'
end
