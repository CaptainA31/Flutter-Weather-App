import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/weather_bloc.dart';
import '/repository/weather_repository.dart';
import '/view/weather_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => WeatherRepository(),
      child: BlocProvider(
        create: (context) => WeatherBloc(
          weatherRepository: context.read<WeatherRepository>(),
        ),
        child: MaterialApp(
          title: 'Weather App',
          theme: ThemeData(primarySwatch: Colors.teal),
          home: WeatherPage(),
        ),
      ),
    );
  }
}
