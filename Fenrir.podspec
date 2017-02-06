Pod::Spec.new do |s|
  s.name = 'Fenrir'
  s.module_name = 'Fenrir'
  s.version = '0.0.5'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.summary = 'An app flow tracker for iOS written in Swift.'
  s.homepage = 'https://github.com/movile/Fenrir-iOS'
  s.authors = { 'Bruno Rocha' => 'bruno.rocha@movile.com' }
  s.source = { :git => 'https://github.com/movile/Fenrir-iOS.git', :tag => "#{s.version}" }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Fenrir/*/*.swift'
end