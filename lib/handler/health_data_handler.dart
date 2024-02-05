import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pigeon_poc/generated/pigeons.g.dart';

class HealthDataHandler extends HealthDataFlutterApi {
  HealthDataHandler({required HealthDataHostApi hostApi}) : _hostApi = hostApi {
    HealthDataFlutterApi.setup(this);
  }

  final HealthDataHostApi _hostApi;

  final StreamController<TimeSeriesData> _heartRateController = StreamController.broadcast();
  Stream<TimeSeriesData> get heartRateStream => _heartRateController.stream;

  final StreamController<TimeSeriesData> _stepsController = StreamController.broadcast();
  Stream<TimeSeriesData> get stepsStream => _stepsController.stream;

  @override
  void onHeartRateAdded(TimeSeriesData data) => _heartRateController.add(data);

  Future<Either<PlatformException, List<TimeSeriesData>>> getHeartRate() async {
    final now = DateTime.now();
    try {
      final response = await _hostApi.getHeartRate(
        now.subtract(const Duration(hours: 1)).millisecondsSinceEpoch,
        now.millisecondsSinceEpoch,
      );

      if (response == null) {
        return right([]);
      } else {
        return right(response.cast());
      }
    } on PlatformException catch (e) {
      return left(e);
    }
  }
}
