# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'

use_frameworks!

target ‘WeatherTalentoMobile’ do
pod 'Alamofire', '~> 4.4'
pod 'Realm', '~> 2.4'
pod 'RealmSwift', '~> 2.4'
pod 'AlamofireObjectMapper', '~> 4.1'
pod 'IQKeyboardManagerSwift', '~> 4.0'

end



post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
