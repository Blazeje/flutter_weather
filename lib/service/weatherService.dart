import 'package:flutter_weather/model/weather.dart';
import 'package:hive/hive.dart';

class WeatherService {
  late Box<Weather> _weather;

  Future<void> init() async{
    Hive.registerAdapter(WeatherAdapter());
    _weather = await Hive.openBox('weather');
  }
  Future<List<Weather>> getWeather(final String cityName) async {
    final weather = _weather.values;
    return weather.toList();
  }
  void addWeather(final String cityName, final double weatherTemp, final double weatherTempMin, final double weatherTempMax){
      _weather.add(Weather(cityName, weatherTemp, weatherTempMin, weatherTempMax));
  }
}