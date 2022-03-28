import 'package:http/http.dart' as http;
import 'dart:convert';
import 'WeatherModel.dart';

class WeatherRepo{
  Future<WeatherModel> getWeather(String city) async{
    final queryParameters = {
      'q': city,
      'appid': '3e3a8c37c086a23d89dd2610ad0dbec8',
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final result = await http.get(uri);
     if(result.statusCode != 200)
       throw Exception();

     return parsedJson(result.body);
  }
  WeatherModel parsedJson(final response){
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonWeather);
  }
}