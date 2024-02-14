//
//  BleScannerFlutterApiImpl.swift
//  Runner
//
//  Created by Danijel Tolj on 13. 2. 2024..
//

import Foundation
import CoreBluetooth

class BleScannerFlutterApiImpl : NSObject, BluetoothManagerStatusListener{
    private let flutterApi: BleScannerFlutterApi
    private let centralManager: CBCentralManager
    private var bluetoothStatusDelegate: CBCentralManagerDelegate?
    
    init(binaryMessenger: FlutterBinaryMessenger, centralManager: CBCentralManager) {
        self.flutterApi = BleScannerFlutterApi(binaryMessenger: binaryMessenger)
        self.centralManager = centralManager
    }
    
    func attachListener() {
        bluetoothStatusDelegate = BluetoothStatusDelegate(listener: self)
        centralManager.delegate = bluetoothStatusDelegate
    }
    
    func deattachListener(){
        bluetoothStatusDelegate = nil
        centralManager.delegate = nil
    }
    
    
    func onBluetoothStateChanged(state: CBManagerState) {
        let status: BluetoothStatus? = switch(state){
        case .poweredOff:
                .poweredOff
        case .poweredOn:
                .poweredOn
        default:
            nil
        }
        
        if let status = status {
            flutterApi.onBluetoothStatusChanged(status: status) { _ in }
        }
    }
    
    
}
