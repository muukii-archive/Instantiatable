Pod::Spec.new do |s|
  s.name             = "Instantiatable"
  s.version          = "0.1.0"
  s.summary          = "Instantiate from XIB or Storyboard"
  s.description      = <<-DESC
  Type-safe Instantiate from XIB or Storyboard.
                       DESC

  s.homepage         = "https://github.com/muukii/Instantiatable"
  s.license          = 'MIT'
  s.author           = { "muukii" => "m@muukii.me" }
  s.source           = { :git => "https://github.com/muukii/Instantiatable.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.2'

  s.source_files = 'Instantiatable/Classes/**/*'
end
