Pod::Spec.new do |spec|

  spec.name         = "ToggleSwitch"
  spec.version      = "1.0.0"
  spec.summary      = "Awesome toggle switch with labels"
  spec.description  = "You can include include in your project."
  spec.homepage     = "https://github.com/Nova-Corp/Toggle-Switch-With-Label"
  spec.license      = "MIT"

  spec.author             = { "Shanmugarajeshwaran R" => "shanmugarajeshwaran@sparkouttech.com" }
  spec.social_media_url   = "https://www.instagram.com/sharveshwaran.r"

  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/Nova-Corp/Toggle-Switch-With-Label.git", :tag => "#{spec.version}" }

  spec.source_files  = "Toggle-Switch-With-Label/ToggleSwitch/**/*.{swift}"
  spec.swift_versions = "5.0"
  
end
