Pod::Spec.new do |s|
  s.name         = "ARMapView”
  s.version      = “0.0.01”
  s.summary      = "A MKMapView that can user CLLocationManager for better user location tracking”

  s.description  = <<-DESC
                   A MapView that can user CLLocationManager so we can ask for permissions and get better tracking.
                   DESC

  s.homepage     = "https://github.com/AlexmReynolds/ARMapView”
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "License" }

  s.author       = { "Alex Reynolds" => "alex.micheal.reynolds@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/AlexmReynolds/ARMapView.git", :tag => “0.0.1” }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any h, m, mm, c & cpp files. For header
  #  files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "ARMapView/*.{h,m}”
  s.public_header_files = "ARMapView/*.h"

  s.requires_arc = true

end