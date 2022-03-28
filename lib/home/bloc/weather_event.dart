part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeatherEvent extends WeatherEvent{
  final city;

  FetchWeatherEvent(this.city);
  @override
  // TODO: implement props

  List<Object> get props => [city];
}

class ResetWeatherEvent extends WeatherEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class NoConnectEvent extends WeatherEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class NotSearchedEvent extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
