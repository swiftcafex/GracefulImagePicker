#
# Be sure to run `pod lib lint GracefulImagePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GracefulImagePicker'
  s.version          = '0.1.4'
  s.summary          = 'A functional UI component for pick image on iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    A functional UI component for pick image on iOS. .
                       DESC

  s.homepage         = 'https://github.com/swiftcafex/GracefulImagePicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SwiftCafe' => 'swiftcafex@gmail.com' }
  s.source           = { :git => 'https://github.com/swiftcafex/GracefulImagePicker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GracefulImagePicker/Classes/**/*'

  s.resources = 'GracefulImagePicker/Assets/*.png'
  s.resource_bundles = {
    'GracefulImagePicker' => ['GracefulImagePicker/Assets/*.png']
  }

  s.dependency 'CircleProgressBar'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

  # s.dependency 'AFNetworking', '~> 2.3'
end
