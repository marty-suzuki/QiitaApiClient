#
# Be sure to run `pod lib lint QiitaApiClient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QiitaApiClient'
  s.version          = '0.2.0'
  s.summary          = 'API client for http://qiita.com/.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

#  s.description      = <<-DESC
#  TODO: Add long description of the pod here.
#                       DESC

  s.homepage         = 'https://github.com/marty-suzuki/QiitaApiClient'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marty-suzuki' => 's1180183@gmail.com' }
  s.source           = { :git => 'https://github.com/marty-suzuki/QiitaApiClient.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/marty_suzuki'

  s.ios.deployment_target = '8.0'

  s.source_files = 'QiitaApiClient/**/*.{swift}'

  # s.resource_bundles = {
  #   'QiitaApiClient' => ['QiitaApiClient/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'WebKit'
  s.dependency 'MisterFusion', '~> 2.0.0'
end
