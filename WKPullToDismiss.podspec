#
# Be sure to run `pod lib lint WKPullToDismiss.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WKPullToDismiss'
  s.version          = '1.0.1'
  s.summary          = 'Interactive modal pull to dismiss transition.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Reference to the demo application and the description on github. Additional information is available in the module's annotations/comments.
                       DESC

  s.homepage         = 'https://github.com/stuffrabbit/WKPullToDismiss'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wojtek Kordylewski' => 'stuffrabbit@yahoo.de' }
  s.source           = { :git => 'https://github.com/stuffrabbit/WKPullToDismiss.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'
  s.swift_version = '5.0'
  s.source_files = 'Classes/**/*'
  
  # s.resource_bundles = {
  #   'WKPullToDismiss' => ['WKPullToDismiss/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
