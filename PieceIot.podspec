Pod::Spec.new do |s|
    s.name = 'PieceCoreIot'
    s.version = '0.0.01'
    s.license = { :type => 'GPL v3', :file => 'LICENSE' }
    s.summary = 'This is piece iot library for iOS.'
    s.homepage = 'https://jokapi.jp'
    s.author = "jokerpiece"
    s.source = { :git => "https://github.com/jokerpiece/iphone-piececore-iot.git", :tag => "#{s.version}"}
    s.platform  = :ios, "8.0"
    s.source_files = "IotCore/**/*.{h,m}"
    s.resources = "IotCore/Resources/**/*.{png, jpg,gif}","IotCore/**/*.xib"
    s.dependency = 'PieceCore', :git => 'https://github.com/jokerpiece/PieceCore.git'
end
