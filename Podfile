use_frameworks!
platform :ios, '11.0'
source 'https://github.com/CocoaPods/Specs.git'

def shared_pods
  pod 'AlamofireImage'
  pod 'RxSwift', '~> 4.0'
  pod 'RxCocoa', '~> 4.0'
  pod 'RxDataSources', '~> 3.0'
  pod 'Action'	
end

def test_pods
      pod 'RxBlocking'
      pod 'Nimble'
      pod 'Quick'
      pod 'RxNimble'
      pod 'GCDWebServer', '~> 3.0'
end

target 'TheMovieRx' do
  shared_pods
end

target 'TheMovieRxTests' do
  shared_pods
  test_pods
end

target 'TheMovieRxUITests' do
    shared_pods
    test_pods
end
