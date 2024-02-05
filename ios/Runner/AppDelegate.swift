import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var _healthPlugin: HealthDataPlugin!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      
      let controller = window?.rootViewController as! FlutterViewController
      registerHealthDataPlugin(binaryMessenger: controller.binaryMessenger)
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func registerHealthDataPlugin (binaryMessenger: FlutterBinaryMessenger ) -> Void {
        _healthPlugin = HealthDataPlugin(binaryMessenger: binaryMessenger)
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        _healthPlugin.dispose()
        return super.applicationWillTerminate(application)
    }
}
