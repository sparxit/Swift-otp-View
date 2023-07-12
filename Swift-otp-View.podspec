Pod::Spec.new do |s|
s.name             = 'Swift-otp-View'  
s.version          = '1.0.0'  
s.summary          = 'The OTP Screen allows you to display OTP fields with different layouts and
animations base on your needs.' 
s.description      = <<-DESC
                   The objective of the OTP Screen is to provide an easy and customisable
way to integrate an OTP (One-Time Password) view into your iOS application. This documentation will guide you through the process of integrating the OTP screen, including various customisation options such as colour, animations, and fonts.
DESC

s.homepage         = 'https://github.com/santosh-k/Swift-otp-View.git' 
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'sparxit' => 'abhishek@sparxitsolutions.com' } 
s.source           = { :git => 'https://github.com/santosh-k/Swift-otp-View.git', :commit =>
"0d5cdb7cbbae896ddb317291407897670c149a41" } 
s.ios.deployment_target = '13.0'
s.source_files     =   'OTP/**/*.swift'
end