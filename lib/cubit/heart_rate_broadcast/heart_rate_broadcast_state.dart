part of 'heart_rate_broadcast_cubit.dart';

sealed class HeartRateBroadcastState extends Equatable {
  const HeartRateBroadcastState();

  @override
  List<Object?> get props => [];
}

class HeartRateBroadcastInitial extends HeartRateBroadcastState {
  const HeartRateBroadcastInitial();
}

class HeartRateBroadcastData extends HeartRateBroadcastState {
  final TimeSeriesEntry record;

  const HeartRateBroadcastData({required this.record});

  @override
  List<Object?> get props => [record];
}
