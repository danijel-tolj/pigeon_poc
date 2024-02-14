import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/generated/pigeons.g.dart',
  kotlinOut: 'android/app/src/main/kotlin/com/example/pigeon_poc/generated/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/Generated/Messages.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'pigeon_poc',
))

// data classes
enum BluetoothStatus {
  poweredOn,
  poweredOff,
  resetting,
  unauthorized,
  notSupported,
}

class TimeSeriesData {
  final int timestamp;
  final int data;

  TimeSeriesData({required this.timestamp, required this.data});
}

class StepsData {
  final int timestamp;
  final int data;

  StepsData({required this.timestamp, required this.data});
}

// Flutter -> Native
@HostApi()
abstract class HealthDataHostApi {
  @async
  List<TimeSeriesData> getHeartRate(int from, int to);
  @async
  List<StepsData> getSteps(int timestampFrom, int timestampTo);
}

// Native -> Flutter
@FlutterApi()
abstract class HealthDataFlutterApi {
  void onHeartRateAdded(TimeSeriesData data);
}

@FlutterApi()
abstract class BleScannerFlutterApi {
  void onBluetoothStatusChanged(BluetoothStatus status);
}
