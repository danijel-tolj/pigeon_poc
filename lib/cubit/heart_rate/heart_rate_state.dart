part of 'heart_rate_cubit.dart';

sealed class HeartRateState extends Equatable {
  const HeartRateState();

  @override
  List<Object?> get props => [];
}

class HeartRateInitial extends HeartRateState {
  const HeartRateInitial();
}

class HeartRateLoading extends HeartRateState {
  const HeartRateLoading();
}

class HeartRateData extends HeartRateState {
  final List<TimeSeriesEntry> records;

  const HeartRateData({required this.records});

  @override
  List<Object?> get props => [records];
}

class HeartRateError extends HeartRateState {
  final String error;
  const HeartRateError(this.error);

  @override
  List<Object?> get props => [error];
}
