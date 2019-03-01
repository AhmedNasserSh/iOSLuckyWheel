Pod::Spec.new do |s|
  s.name             = 'iOSLuckyWheel'
  s.version          = '0.1.1'
  s.summary          = 'An iOS Lucky wheel with customizable text and text colors and section colors and very easy to integrate '
  s.description      =  ' An iOS Lucky wheel in swift with customizable text and text colors and section colors and very easy to integrate'

  s.homepage         = 'https://github.com/AvaVaas'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AVAVaas' => 'ahmed.nasser2310@gmail.com' }
  s.source           = { :git => 'https://github.com/AvaVaas/iOSLuckyWheel.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'iOSLuckyWheel/Classes/**/*.{swift}'
  s.frameworks = 'UIKit'
  s.frameworks = 'CoreGraphics'
  s.swift_version = '4.2'
  
end
