import 'package:flutter_bloc/flutter_bloc.dart';
import 'weather_event.dart';
import 'weather_state.dart';
import '../repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : super(const WeatherState()) {
    on<WeatherRequested>(_onWeatherRequested);
  }

  Future<void> _onWeatherRequested(
    WeatherRequested event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await weatherRepository.fetchWeather(event.city);
      emit(state.copyWith(status: WeatherStatus.success, weather: weather));
    } catch (_) {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }
}
