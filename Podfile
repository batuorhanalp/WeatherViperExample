source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

def common_pods
  # Common pods
end

target 'WeatherWithViperPattern' do
  pod 'Reachability', '~> 3'
  pod 'TPKeyboardAvoiding', '~> 1'
  pod 'SDWebImage', :git => 'https://github.com/rs/SDWebImage.git', :tag => '4.0.0'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Alamofire', '~> 4'
  pod 'R.swift', '~> 3'
  pod 'SegueManager', '~> 3'
  pod 'SegueManager/R.swift'
  pod 'Hex', '~> 5'
  pod 'SnapKit', '~> 3'
  pod 'KMPlaceholderTextView', '~> 1.3.0'
  pod 'SwiftDate', '~> 4'
  pod 'lottie-ios', '~> 1.5'
end

target 'WeatherWithViperPatternTests' do
    common_pods
end

target 'WeatherWithViperPatternUITests' do
    common_pods
end
