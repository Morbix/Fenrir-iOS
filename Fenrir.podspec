Pod::Spec.new do |s|
  s.name = 'Fenrir'
  s.module_name = 'Fenrir'
  s.version = '0.0.1'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.summary = 'An app flow tracker for iOS written in Swift.'
  s.homepage = 'https://github.com/movile/Pato-iOS'
  s.authors = { 'Bruno Rocha' => 'bruno.rocha@movile.com' }
  s.source = { :git => 'https://github.com/movile/Pato-iOS.git', :tag => "v#{s.version}" }
  s.ios.deployment_target = '9.2'
  s.source_files = 'Pato/*.swift'
end