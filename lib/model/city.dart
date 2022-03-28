import 'package:hive/hive.dart';

part 'city.g.dart';

@HiveType(typeId: 1)
class City {
  @HiveField(0)
   final String cityName;

  City(this.cityName);
}