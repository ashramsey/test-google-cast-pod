class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'test-google-cast-pod'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible


    # chromecast setup
    options = GCKCastOptions.alloc.initWithReceiverApplicationID("5609EA1F")
    GCKCastContext.setSharedInstanceWithOptions(options)
    GCKLogger.sharedInstance.setDelegate self


    true
  end
end
