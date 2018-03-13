Pod::Spec.new do |s|
  s.name         = "FRAlertController"
  s.version      = "1.0.3"
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = '7.0'
  s.summary      = "A modeled system UIAlertController to achieve FRAlertController"
  s.homepage     = "https://github.com/fanrongQu/FRAlertController"
  s.license      = {:type => 'MIT', :file => "LICENSE"}
  s.author       = {"FR" => "1366225686@qq.com"}
  s.source       = {:git => "https://github.com/fanrongQu/FRAlertController.git", :tag => s.version }
  s.source_files  = "FRAlertController"
  
end
