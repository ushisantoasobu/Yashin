#
# Be sure to run `pod lib lint Yashin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Yashin"
  s.version          = "0.2.0"
  s.summary          = "Simple Rader Chart written in Swift."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "With setting up 2 lines of code and data-list, you can draw simple but cool Rader Chart"

  s.homepage         = "https://github.com/ushisantoasobu/Yashin"
  # s.screenshots      = "https://github.com/ushisantoasobu/Yashin/blob/master/screenshots/1", "https://github.com/ushisantoasobu/Yashin/blob/master/screenshots/2"
  s.license          = 'MIT'
  s.author           = { "ushisantoasobu" => "babblemann.shunsee@gmail.com" }
  s.source           = { :git => "https://github.com/ushisantoasobu/Yashin.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ushisantoasobu'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Yashin' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
