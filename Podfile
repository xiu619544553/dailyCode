source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!

# app-target 与 extension 共用的三方库
def sharedPods
    pod 'Masonry'
    pod 'YYKit'
end

# app-target
target 'dailyCode' do
  
  sharedPods
  
#  pod 'FPSLabel'
  pod 'SDWebImage', '5.9.0'
  pod 'WMPageController', '2.5.2'
  pod 'RTRootNavigationController', '~> 0.7.0'
  
  pod 'TKCategory', :path => '../TKCategory'
  pod 'FLEX', '4.1.1', :configurations => ['Debug']
  
  pod 'SVProgressHUD'
  
end

# extension
target 'dailyCodeWidget' do
  sharedPods
end
