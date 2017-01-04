# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'rubygems'
require 'motion-cocoapods'

require 'sugarcube-repl'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'test-google-cast-pod'

  app.embedded_frameworks += ["vendor/Pods/google-cast-sdk/GoogleCastSDK-Public-3.3.0-Release/GoogleCast.framework"]

  app.pods :bridgesupport_cflags => "-I'./Headers/Public/google-cast-sdk/GoogleCast'" do
    pod 'google-cast-sdk', '~> 3.3.0'
  end

end
