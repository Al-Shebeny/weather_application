import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/weather_cubit.dart';
import '../cubits/weather_state.dart';
import '../models/weather_model.dart';
import 'search_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: BlocBuilder<WeatherCubite, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherSuccess) {
          return SuccessView(weatherData: state.weatherModel);
        } else if (state is WeatherFailure) {
          return const Center(
            child: Text('there is some thing wronge'),
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'there is no weather 😔 start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  'searching now 🔍',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

class SuccessView extends StatelessWidget {
  const SuccessView({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
              weatherData!.getThemeColor(),
              weatherData!.getThemeColor()[300]!,
              weatherData!.getThemeColor()[100]!,
            ])),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Text(
              BlocProvider.of<WeatherCubite>(context).cityName!,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              'Update at : ${weatherData!.date.hour} : ${weatherData!.date.minute}',
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(weatherData!.getImage()),
                Text(
                  '${weatherData!.temp.toInt()}',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(
                      'maxTemp : ${weatherData!.maxTemp.toInt()}',
                    ),
                    Text(
                      'minTemp : ${weatherData!.minTemp.toInt()}',
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Text(
              weatherData!.weatherStateName,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 5),
          ],
        ));
  }
}
