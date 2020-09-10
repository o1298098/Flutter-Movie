import UIKit
import Flutter
import flutter_downloader
import Braintree

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    BTAppSwitch.setReturnURLScheme("com.o1298098.movies.payments")
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
private func registerPlugins(registry: FlutterPluginRegistry) { 
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin"))
    }
}
override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "com.o1298098.movies.payments" {
            return BTAppSwitch.handleOpen(url, options:options)
        }
        
        return false
}
