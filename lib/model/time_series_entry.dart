import 'package:equatable/equatable.dart';

class TimeSeriesEntry extends Equatable {
  final DateTime time;
  final int value;

  const TimeSeriesEntry({required this.time, required this.value});

  @override
  List<Object?> get props => [time, value];
}
