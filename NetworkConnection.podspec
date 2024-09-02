Pod::Spec.new do |spec|

  spec.name         = "NetworkConnection"
  spec.version      = "1.0.1"
  spec.summary      = "Network Connection manager Package"

  spec.description  = "NetworkManager is an iOS library for monitoring network connectivity status and quality. It allows you to easily detect when the device is connected or disconnected from the internet, as well as assess the quality of the connection."

  spec.homepage     = "https://github.com/Malsaeed276/NetworkConnectionManager"
  spec.license      = "MIT"
  spec.author             = { "Mohamed Elsaeed" => "mohamed.elsaeed276@gmail.com" }

  spec.platform     = :ios
  spec.platform     = :ios, "15.0"

  spec.source       = { :git => "https://github.com/Malsaeed276/NetworkConnectionManager.git", :tag => spec.version.to_s }

  spec.source_files  = "NetworkConnection/**/*.{swift}"



  # spec.resource  = "icon.png"
# spec.resources = "Sources/NetworkConnection/Resources/Localizable.xcstrings"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  #  spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"
  
  spec.swift_version = "5.0"
end
