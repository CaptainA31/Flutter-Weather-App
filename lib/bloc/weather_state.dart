import 'package:equatable/equatable.dart';
import '../models/weather.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather? weather;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, weather];
}
