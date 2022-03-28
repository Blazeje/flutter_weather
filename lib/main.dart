import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/http/WeatherConnectService.dart';
import 'http/WeatherRepo.dart';
import 'home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          backgroundColor: Colors.blue[700],
          primarySwatch: Colors.blue,
        ),
        home: MultiRepositoryProvider(

          providers:[
            RepositoryProvider(create: (context)=> WeatherRepo()),
            RepositoryProvider(create: (context) => WeatherConnect()),
          ],
          child: SearchPage(),
        ),
    );
  }
}