#
# Be sure to run `pod lib lint Bumbo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Bumbo'
  s.version          = '1.1.0'
  s.summary          = 'A swifty client for Thumbor'

  s.description      = <<-DESC
Bumbo is a client for [Thumbor](https://github.com/thumbor/thumbor) written in Swift.
It helps you adding filters to images without worries.
                       DESC

  s.homepage         = 'https://github.com/guilhermearaujo/Bumbo'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Guilherme Araújo' => 'guilhermeama@gmail.com' }
  s.source           = { :git => 'https://github.com/guilhermearaujo/Bumbo.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Bumbo/**/*'

  s.dependency 'CryptoSwift', '~> 0.8.1'
end
