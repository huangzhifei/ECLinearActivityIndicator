Pod::Spec.new do |s|

  s.name         = "ECLinearActivityIndicator"
  s.version      = "0.0.5"
  s.summary      = "Add the missing network activity indicator on iPhone X"

  s.description  = <<-DESC
  iPhone X does not display the network activity indicator anymore. This pod brings it
 	 back by placing an activity indicator in the upper left of the screen on top of the
 	 regular status bar items. Since a circular indicator wouldn't fit, a rectangular 
 	 "KITT scanner" like indicator with a gradient is shown. The indicator UI can be
 	 used standalone or as a "fix" for the iOS network activity indicator (using the
 	 existing API)
                   DESC

  s.homepage     = "https://github.com/huangzhifei/ECLinearActivityIndicator"

  s.license      = "MIT"

  s.author             = { "hzf" => "huangzhifei2009@126.com" }

  s.platform     = :ios

  s.ios.deployment_target = "7.0"

  s.source       = { :git => "https://github.com/huangzhifei/ECLinearActivityIndicator.git", :tag => s.version }

  s.source_files  = "ECLinearActivityIndicator/class/*.{h,m}"

  s.frameworks  = "UIKit"

  s.requires_arc = true

end
