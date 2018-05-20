#
# Be sure to run `pod lib lint ganilib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GaniLib'
  s.version          = '0.6.0'
  s.summary          = 'Simplify iOS development'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hgani/ganilib-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hgani' => 'hendrik.gani@gmail.com' }
  s.source           = { :git => 'https://github.com/hgani/ganilib-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ganilib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ganilib' => ['ganilib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftIconFont', '2.7.3'
  s.dependency 'SideMenu', '~> 3.0'
	s.dependency 'SnapKit', '~> 4.0'
  s.dependency 'Eureka', '~> 4.1'
  s.dependency 'TTTAttributedLabel'

  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'SVProgressHUD'
  s.dependency 'Kingfisher', '~> 4.0'
  s.dependency 'XLPagerTabStrip', '~> 8.0'
  
  # http://www.dbotha.com/2014/12/04/optional-cocoapod-dependencies/
  s.default_subspec = 'Core'

  s.subspec 'Core' do |image|
    image.xcconfig = { 'OTHER_SWIFT_FLAGS' => '' }
  end

  s.subspec 'Realm' do |image|
    image.xcconfig = { 'OTHER_SWIFT_FLAGS' => '-DINCLUDE_REALM' }
    image.dependency 'RealmSwift', '~> 3.0'
  end
end
