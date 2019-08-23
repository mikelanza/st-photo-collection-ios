Pod::Spec.new do |s|
 s.name = 'STPhotoCollection'
 s.version = '0.0.1'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'Photo collection for Streetography'
 s.homepage = 'https://streetography.com'
 s.social_media_url = 'https://twitter.com/ '
 s.authors = { "Streetography" => "info@streetography.com" }
 s.source = { :git => "https://github.com/mikelanza/STPhotoCollection.git", :tag => s.version.to_s }
 s.platforms = { :ios => "11.0" }
 s.requires_arc = true
 s.swift_versions = ['5.0']

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/**/*.swift"
     ss.framework  = "Foundation"
 end
end
