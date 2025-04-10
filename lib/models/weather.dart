import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String city;
  final double temperature;

  const Weather({required this.city, required this.temperature});

  @override
  List<Object> get props => [city, temperature];
}
