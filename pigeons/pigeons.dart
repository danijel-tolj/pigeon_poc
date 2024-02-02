import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/generated/pigeons.g.dart',
  kotlinOut: 'android/app/src/main/kotlin/com/example/pigeon_poc/generated/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/Generated/Messages.g.swift',
  swiftOptions: SwiftOptions(),
  dartPackageName: 'pigeon_poc',
))
enum DeviceType { appleWatch, ouras }

// data classes
class TimeSeriesData {
  final int timestamp;
  final int data;

  TimeSeriesData({required this.timestamp, required this.data});
}

class FirmwareStatusResponse {
  final FirmwareUpdateStatus status;
  final String value;

  FirmwareStatusResponse({required this.status, required this.value});
}

enum FirmwareUpdateStatus { updating, error, done }

// Flutter -> Native
@HostApi()
abstract class HealthDataHostApi {
  @async
  List<TimeSeriesData>? getHeartRate(int from, int to);
}

// Native -> Flutter
@FlutterApi()
abstract class HealthDataFlutterApi {
  void onHeartRateAdded(TimeSeriesData data);
  void onStepsAdded(TimeSeriesData data);
  void onFirmwareStatusUpdate(FirmwareStatusResponse data);
}
