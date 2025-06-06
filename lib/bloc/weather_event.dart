import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

// When user searches for weather by city
class WeatherRequested extends WeatherEvent {
  final String city;

  const WeatherRequested({required this.city});

  @override
  List<Object> get props => [city];
}
