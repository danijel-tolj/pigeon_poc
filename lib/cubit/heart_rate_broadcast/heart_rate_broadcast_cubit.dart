import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pigeon_poc/handler/health_data_handler.dart';
import 'package:pigeon_poc/model/time_series_entry.dart';

part 'heart_rate_broadcast_state.dart';

class HeartRateBroadcastCubit extends Cubit<HeartRateBroadcastState> {
  final HealthDataHandler _handler;

  HeartRateBroadcastCubit(this._handler) : super(const HeartRateBroadcastInitial()) {
    _handler.heartRateStream.listen((event) {
      emit(
        HeartRateBroadcastData(
          record: TimeSeriesEntry(
            time: DateTime.fromMillisecondsSinceEpoch(event.timestamp),
            value: event.data,
          ),
        ),
      );
    });
  }
}
