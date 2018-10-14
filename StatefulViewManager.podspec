#
#  Be sure to run `pod spec lint StatefulViewManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "StatefulViewManager"
  s.version      = "0.0.1"
  s.summary      = "A short description of StatefulViewManager."
  s.description  = <<-DESC
  StatefulViewManager
                   DESC

  s.ios.deployment_target = '10.3'

  s.homepage     = "http://EXAMPLE/StatefulViewManager"

  s.license = { :type => "MIT", :file => "LICENSE" }

  s.authors            = [{ "John Crossley" => "jonnysnip3r@gmail.com" }, { "James Ruston" => "jruston90@gmail.com" }]
  s.social_media_url   = "https://twitter.com/JonnoTheBonno"

  s.source       = { :git => "https://github.com/john-crossley/StatefulViewManager.git", :tag => "#{s.version}" }

  s.framework = "UIKit"
  s.source_files = "StatefulViewManager/**/*.{swift}"

  s.resources = "StatefulViewManager/**/*.{png,jpeg,jpg,storyboard,xib,xcasset}"

  s.swift_version = "4.2"
end
