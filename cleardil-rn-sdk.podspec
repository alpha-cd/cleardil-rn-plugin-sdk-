require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "cleardil-rn-sdk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
  cleardil-rn-sdk
                   DESC
  s.homepage     = "https://github.com/ClearDil/cleardil_ios_sdk"
  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/ClearDil/cleardil_ios_sdk.git", :tag => '1.2.0' }
  # s.source       = { :git => "https://github.com/ClearDil/cleardil_ios_sdk.git", :tag => '1.1.0' }
  s.source_files = "ios/**/*.{h,m,swift}"
  s.exclude_files = "ios/ClearDilSdkTests/"
  s.requires_arc = true
  s.dependency "React"
   s.dependency "cleardil_ios_sdk" , "1.2.0"
  # ...
  # s.dependency "..."
end
