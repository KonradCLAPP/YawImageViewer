#
# Be sure to run `pod lib lint YawImageViewer.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YawImageViewer"
  s.version          = "0.1.10"
  s.summary          = "Facebook Paper like effect for horizontal image browsing"
  s.description      = <<-DESC
                       If you have a photo that is vertical and you would like to present it on iPhone horizontal screen, than YawImageViewer is what you are looking for! YawImageViewer is a view that implements Facebook Paper like effect for image browsing. After presenting that view user see only center of a photo, buy tilt movement user can see other parts of image.
DESC
  s.homepage         = "https://github.com/KonradCLAPP/YawImageViewer"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "KonraCLAPP" => "kgnoinski@clapp.de" }
  s.source           = { :git => "https://github.com/KonradCLAPP/YawImageViewer.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'YawImageViewer' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
