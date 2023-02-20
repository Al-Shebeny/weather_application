import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/weather_cubit.dart';
import 'pages/home_page.dart';
import 'services/weather_services.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => WeatherCubite(WeatherServices()),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: BlocProvider.of<WeatherCubite>(context)
                .weatherModel
                ?.getThemeColor() ??
            Colors.blue,
      ),
      home: SafeArea(child: HomePage()),
    );
  }
}
