//
//  BluetoothManager.swift
//  Runner
//
//  Created by Danijel Tolj on 13. 2. 2024..
//

import Foundation
import CoreBluetooth


class BluetoothStatusDelegate: NSObject, CBCentralManagerDelegate{
    private let listener: BluetoothManagerStatusListener
    
    init(listener: BluetoothManagerStatusListener) {
        self.listener = listener
        super.init()
    }
    
    // MARK: - CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        listener.onBluetoothStateChanged(state: central.state)
    }
}

protocol BluetoothManagerStatusListener{
    func onBluetoothStateChanged(state: CBManagerState)
}
