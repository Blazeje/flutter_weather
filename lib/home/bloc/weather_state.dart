part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
   WeatherState();
}


class WeatherIsLoadingState extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class WeatherIsLoadedState extends WeatherState{
  final double weatherTemp;
  final double weatherTempMax;
  final double weatherTempMin;

  WeatherIsLoadedState(this.weatherTemp, this.weatherTempMax, this.weatherTempMin);
  @override
  List<Object> get props => [weatherTemp, weatherTempMax, weatherTempMin];
}

class WeatherNotSearchedState extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class WeatherNotLoadedState extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class WeatherNoConnectState extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
