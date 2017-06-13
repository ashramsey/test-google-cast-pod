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

# require 'sugarcube-repl'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'test-google-cast-pod'

  app.development do
    app.codesign_certificate = "iPhone Developer: Ashley Ramsey (RVSG82V4WN)"
    app.provisioning_profile = 'shift72-development.mobileprovision'
  end

  # GoogleCast.framework is a dynamic framework, not a fake static framework
  # so we need to add it as an embedded framework
  app.embedded_frameworks += ["vendor/GoogleCast.framework"] if File.exist?("vendor/GoogleCast.framework")

  app.pods :bridgesupport_cflags => "-include ./Headers/Public/google-cast-sdk/GoogleCast/GCKDefines.h" do
    pod 'google-cast-sdk', '~> 3.3.0'
  end

  app.libs += [
    "/usr/lib/libz.dylib"
  ]
end


task :install_pods do
  # Install the pods normally
  Rake::Task["clean:all"].invoke
  Rake::Task["pod:install"].invoke
  # Copy the framework we're going to import to the vendor directory
  rm_r 'vendor/GoogleCast.framework'
  cp_r 'vendor/Pods/google-cast-sdk/GoogleCastSDK-Public-3.3.0-Release/GoogleCast.framework', 'vendor'
  # Including the framework in the `embedded frameworks` array will make RM try to generate
  # bridgesupport files for its headers again. Since we already did that via motion-cocoapods,
  # we delete all headers except one (the toolchain needs at least one header).
  # The reason we use the BS generated by the pods and not the one generated by embedded_frameworks
  # is because pods allow us to pass custom cflags to the bridgesupport generator to workaround
  # the GCKDefines bug.
  rm(Dir.glob('vendor/GoogleCast.framework/Headers/*.h').delete_if { |path| path.include?("GCKDefines") })
end
