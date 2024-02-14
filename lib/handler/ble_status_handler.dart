import 'dart:async';

import 'package:pigeon_poc/generated/pigeons.g.dart';

class BleStatusHandler extends BleScannerFlutterApi {
  BleStatusHandler() {
    BleScannerFlutterApi.setup(this);
  }

  final StreamController<BluetoothStatus> _bluetoothStatusStreamController =
      StreamController.broadcast();
  Stream<BluetoothStatus> get heartRateStream => _bluetoothStatusStreamController.stream;

  @override
  void onBluetoothStatusChanged(BluetoothStatus status) =>
      _bluetoothStatusStreamController.add(status);
}
