import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather/http/WeatherConnectService.dart';
import '../../http/WeatherRepo.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepo weatherRepo;
  final WeatherConnect weatherConnect;

  WeatherBloc(this.weatherRepo, this.weatherConnect) : super(WeatherIsLoadingState()){
    weatherConnect.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        print('no internet');
        add(NoConnectEvent());
      } else {
        print('yes internet');
        add(FetchWeatherEvent(event));
      }
    });

    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherNotSearchedState());
      final weather = await weatherRepo.getWeather(event.city);
      emit(WeatherIsLoadedState(weather.temp, weather.tempMin, weather.tempMax));
    });
    on<ResetWeatherEvent>((event, emit) {
      emit(WeatherIsLoadingState());
    });
    on<NoConnectEvent>((event, emit) {
      emit(WeatherNoConnectState());
    });
    on<NotSearchedEvent>((event, emit) {
      emit(WeatherNotSearchedState());
    });

  }
}