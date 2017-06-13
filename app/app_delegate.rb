class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'test-google-cast-pod'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    p 3
    # chromecast setup
    options = GCKCastOptions.alloc.initWithReceiverApplicationID("6522CABE")
    GCKCastContext.setSharedInstanceWithOptions(options)
    GCKLogger.sharedInstance.setDelegate self


    p 2

    true
  end


  def logMessage(message, fromFunction: function)
    if true #@enableSDKLogging
      # Send SDK's log messages directly to the console.
      NSLog "function: #{function}, message: #{message}"
    end
  end
end
