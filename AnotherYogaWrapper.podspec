Pod::Spec.new do |spec|
  spec.name = "AnotherYogaWrapper"
  spec.version = "0.0.1"
  spec.summary = "Another simple swift wrapper of facebook/yoga"
  spec.homepage = "https://github.com/dengcqw/Another-Yoga-Wrapper"
  spec.license = { type: 'GNU General Public License v3.0', file: 'LICENSE' }
  spec.authors = { "dengjinlong" => 'dengcqw@qiyi.com' }
  spec.social_media_url = ""

  spec.platform = :ios, "9.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/dengcqw/Another-Yoga-Wrapper.git" }
  spec.source_files = "{Sources}/*.{swift}"
  spec.frameworks = 'UIKit'
  spec.dependency 'YogaKit', '~> 1.9'
  spec.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) YOGA=1' }
end
