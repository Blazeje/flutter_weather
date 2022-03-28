import 'package:hive/hive.dart';

part 'weather.g.dart';

@HiveType(typeId: 2)
class Weather {
  @HiveField(0)
  final String cityName;
  @HiveField(1)
  final double weatherTemp;
  @HiveField(2)
  final double weatherTempMax;
  @HiveField(3)
  final double weatherTempMin;

  Weather(this.cityName, this.weatherTemp, this.weatherTempMax, this.weatherTempMin);

}