Pod::Spec.new do |s|
  s.name             = 'App'
  s.version          = '1.0.0'
  s.summary          = 'High-performance, high-fidelity mobile apps.'
  s.description      = <<-DESC
Flutter provides an easy and productive way to build and deploy high-performance mobile apps for Android and iOS.
                       DESC
  s.homepage         = 'https://github.com/livesxu/xxx.git'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Flutter Dev Team' => 'xxx' }
  s.source           = { :git => 'https://github.com/livesxu/xxx.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.vendored_frameworks = 'App.framework'
end
