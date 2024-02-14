import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pigeon_poc/generated/pigeons.g.dart';
import 'package:pigeon_poc/handler/ble_status_handler.dart';

part 'bluetooth_status_broadcast_state.dart';

class BluetoothStatusBroadcastCubit extends Cubit<BluetoothStatusBroadcastState> {
  final BleStatusHandler _handler;

  BluetoothStatusBroadcastCubit(this._handler) : super(const BluetoothStatusBroadcastInitial()) {
    _handler.heartRateStream.listen((event) {
      emit(
        BluetoothStatusBroadcastData(
          status: event,
        ),
      );
    });
  }

  init() async {
    emit(const BluetoothStatusBroadcastRequestingPermission());

    final permissions = await Future.wait([
      Permission.bluetooth.isGranted,
      Permission.bluetoothAdvertise.isGranted,
      Permission.bluetoothConnect.isGranted,
      Permission.bluetoothScan.isGranted,
    ]);

    if (permissions.contains(false)) {
      final results = <bool>[];
      await Future.forEach([
        await Permission.bluetooth.request().isGranted,
        await Permission.bluetoothAdvertise.request().isGranted,
        await Permission.bluetoothConnect.request().isGranted,
        await Permission.bluetoothScan.request().isGranted,
      ], (completion) => results.add(completion));

      if (results.all((t) => true)) {
        emit(const BluetoothStatusBroadcastWaitingStatuses());
      }
    } else {
      emit(const BluetoothStatusBroadcastWaitingStatuses());
    }
  }
}
