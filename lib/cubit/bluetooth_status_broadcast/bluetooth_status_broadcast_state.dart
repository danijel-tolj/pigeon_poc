part of 'bluetooth_status_broadcast_cubit.dart';

sealed class BluetoothStatusBroadcastState extends Equatable {
  const BluetoothStatusBroadcastState();

  @override
  List<Object?> get props => [];
}

class BluetoothStatusBroadcastInitial extends BluetoothStatusBroadcastState {
  const BluetoothStatusBroadcastInitial();
}

class BluetoothStatusBroadcastRequestingPermission extends BluetoothStatusBroadcastState {
  const BluetoothStatusBroadcastRequestingPermission();
}

class BluetoothStatusBroadcastWaitingStatuses extends BluetoothStatusBroadcastState {
  const BluetoothStatusBroadcastWaitingStatuses();
}

class BluetoothStatusBroadcastData extends BluetoothStatusBroadcastState {
  final BluetoothStatus status;

  const BluetoothStatusBroadcastData({required this.status});

  @override
  List<Object?> get props => [status];
}
