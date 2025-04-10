import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Enter City'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text;
                context.read<WeatherBloc>().add(
                      WeatherRequested(city: city),
                    );
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                switch (state.status) {
                  case WeatherStatus.initial:
                    return const Text('Please enter a city 🌆');
                  case WeatherStatus.loading:
                    return const CircularProgressIndicator();
                  case WeatherStatus.success:
                    return Column(
                      children: [
                        Text(
                          state.weather!.city,
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          '${state.weather!.temperature.toStringAsFixed(1)} °C',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    );
                  case WeatherStatus.failure:
                    return const Text('Could not fetch weather ❌');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
