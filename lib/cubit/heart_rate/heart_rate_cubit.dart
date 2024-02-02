import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pigeon_poc/handler/health_data_handler.dart';

part 'heart_rate_state.dart';

class HeartRateCubit extends Cubit<HeartRateState> {
  final HealthDataHandler _handler;

  HeartRateCubit(this._handler) : super(const HeartRateInitial());

  Future<void> fetch() async {
    emit(const HeartRateLoading());

    final result = await _handler.getHeartRate();

    emit(
      result.fold(
        (l) => HeartRateError(l.code),
        (r) => HeartRateData(
          records: r
              .map(
                (e) => TimeSeriesEntry(
                  time: DateTime.fromMillisecondsSinceEpoch(e.timestamp),
                  value: e.data,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
