import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class WeatherConnect {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  WeatherConnect() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}