package com.example.pigeon_poc

import android.os.Bundle
import com.example.pigeon_poc.plugin_handlers.BleScannerFlutterApiImpl
import com.example.pigeon_poc.plugin_handlers.HealthDataPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private lateinit var _healthDataPlugin: HealthDataPlugin
    private lateinit var _bluetoothStatusPlugin: BleScannerFlutterApiImpl

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
        registerHealthDataPlugin(flutterEngine!!)  // Initialize and register your plugin
        registerBluetoothPlugin(flutterEngine!!) // Initialize bluetooth status plugin
    }

    private fun registerHealthDataPlugin(engine: FlutterEngine) {
        _healthDataPlugin = HealthDataPlugin(engine.dartExecutor.binaryMessenger)
    }

    private fun registerBluetoothPlugin(engine: FlutterEngine) {
        _bluetoothStatusPlugin = BleScannerFlutterApiImpl(engine.dartExecutor.binaryMessenger)
        _bluetoothStatusPlugin.registerListener(applicationContext)
    }

    override fun onDestroy() {
        _healthDataPlugin.dispose()
        _bluetoothStatusPlugin.unregisterListener(applicationContext)
        super.onDestroy()
    }
}
