import UIKit
import CoreBluetooth
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var healthPlugin: HealthDataPlugin!
    private var bluetoothPlugin: BleScannerFlutterApiImpl?
    private let cbCentralManager:  CBCentralManager = CBCentralManager()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller = window?.rootViewController as! FlutterViewController
        registerHealthDataPlugin(binaryMessenger: controller.binaryMessenger)
        registerBluetoothPlugin(binaryMessenger: controller.binaryMessenger)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func registerHealthDataPlugin (binaryMessenger: FlutterBinaryMessenger ) -> Void {
        healthPlugin = HealthDataPlugin(binaryMessenger: binaryMessenger)
    }
    
    private func registerBluetoothPlugin (binaryMessenger: FlutterBinaryMessenger ) -> Void {
        bluetoothPlugin =  BleScannerFlutterApiImpl(binaryMessenger: binaryMessenger, centralManager: cbCentralManager)
        bluetoothPlugin?.attachListener()
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        healthPlugin.dispose()
        bluetoothPlugin?.deattachListener()
        return super.applicationWillTerminate(application)
    }
}
