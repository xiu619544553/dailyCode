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
  
  pod 'TKCategory', :path => '../TKCategory'
  pod 'FLEX', '4.1.1', :configurations => ['Debug']
  
  pod 'MBProgressHUD'
  pod 'RTRootNavigationController', '0.7.2'
  
end

# extension
target 'dailyCodeWidget' do
  sharedPods
end


# fix warnings: 解决 Pod中 framework与主工程部署版本(deployment version，简称DV)不一致的警告
# 注意: 如果 Pod中有第三方库对最低系统版本有要求 DV > 主工程版本，则不可以使用下面的代码
#post_install do |installer|
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
#        end
#    end
#end

post_install do |installer|
  # 消除版本警告
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end
