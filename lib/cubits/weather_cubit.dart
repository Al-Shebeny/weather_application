import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/weather_model.dart';
import '../services/weather_services.dart';
import 'weather_state.dart';

class WeatherCubite extends Cubit<WeatherState> {
  WeatherCubite(this.weatherServices) : super(WeatherInitial());
  WeatherServices weatherServices;
  WeatherModel? weatherModel;
  String? cityName;
  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherServices.getWeather(cityName: cityName);
      emit(WeatherSuccess(weatherModel: weatherModel!));
    } on Exception {
      emit(WeatherFailure());
    }
  }
}
