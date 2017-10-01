Pod::Spec.new do |s|
  s.name         = "CryptoFeed"
  s.version      = "0.1"
  s.summary      = "Summary"
  s.description  = <<-DESC
    Utility to fetch all crypto coins properties in real time using CoinCap.io API
  DESC
  s.homepage     = "https://github.com/antoniocasero/CryptoFeed"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Antonio Casero" => "anto.casero@gmail.com" }
  s.social_media_url   = "@acaserop"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/antoniocasero/CryptoFeed.git", :tag => s.version.to_s, :submodules => true }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
  s.dependency "Socket.IO-Client-Swift"
end
