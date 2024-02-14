package com.example.pigeon_poc.plugin_handlers

import BleScannerFlutterApi
import BluetoothStatus
import android.bluetooth.BluetoothAdapter
import android.content.Context
import com.example.pigeon_poc.receivers.BluetoothStatusListener
import com.example.pigeon_poc.receivers.BluetoothStatusReceiver
import io.flutter.plugin.common.BinaryMessenger

class BleScannerFlutterApiImpl(binaryMessenger: BinaryMessenger) : BluetoothStatusListener {
    private val _bluetoothReceiver: BluetoothStatusReceiver = BluetoothStatusReceiver(this)
    private val _flutterApi: BleScannerFlutterApi = BleScannerFlutterApi(binaryMessenger)
    fun registerListener(context: Context) {
        _bluetoothReceiver.register(context)
    }

    fun unregisterListener(context: Context) {
        _bluetoothReceiver.unregister(context)
    }

    override fun onBluetoothStatusChange(status: Int) {
        val status = when (status) {
            BluetoothAdapter.STATE_ON -> BluetoothStatus.POWEREDON
            BluetoothAdapter.STATE_OFF -> BluetoothStatus.POWEREDOFF
            else -> null

        }
        if (status != null) {
            _flutterApi.onBluetoothStatusChanged(status) {}
        }
    }
}