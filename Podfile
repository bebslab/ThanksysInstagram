workspace 'InstagramThanksys'

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

# Disable sending stats
ENV['COCOAPODS_DISABLE_STATS'] = 'true'


def instagramthanksys_pods
    pod 'SwiftyJSON'
    pod 'Alamofire'
    pod 'RealmSwift'
    pod 'AFDateHelper', '~> 4.2.2'
end

project 'InstagramThanksys/InstagramThanksys.xcodeproj'

# Pods only used by Thanksys project
target :'InstagramThanksys' do
    instagramthanksys_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

