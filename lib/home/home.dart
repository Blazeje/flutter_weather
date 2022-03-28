import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/http/WeatherConnectService.dart';
import 'package:flutter_weather/http/WeatherRepo.dart';
import 'bloc/weather_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final cityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var cityController = TextEditingController();
    return BlocProvider(
      create: (context) => WeatherBloc(
        RepositoryProvider.of<WeatherRepo>(context),
        RepositoryProvider.of<WeatherConnect>(context),
      )..add(FetchWeatherEvent(context)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather'),
          backgroundColor: Colors.blue[700],
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherNoConnectState) {
            print("NIE MA INETRNETU");
            return Text('no internet');
          } else if (state is WeatherNotSearchedState) {
            return Card(
              child: Column(
                children: <Widget>[
                  Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.blue),),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.blue,),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.black87, style: BorderStyle.solid)),
                      hintText: "City Name",
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      onPressed: () => BlocProvider.of<WeatherBloc>(context)
                          .add(FetchWeatherEvent(cityController.text)),
                      //weatherBloc.add(FetchWeather(cityController.text));

                      color: Colors.lightBlue,
                      child: Text(
                        "Search Weather", style: TextStyle(color: Colors.blueGrey, fontSize: 16),),
                    ),
                  )
                ],
              ),
            );
          } else if (state is WeatherIsLoadingState) {
            print("TU JEST PROBLEM = WEATHER I LOGIND W HOME");
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherIsLoadedState) {
            return Container(
                padding: EdgeInsets.only(right: 32, left: 32, top: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.blue,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.black87,
                                style: BorderStyle.solid)),
                        hintText: "City Name",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () {
                          BlocProvider.of<WeatherBloc>(context)
                              .add(FetchWeatherEvent(cityController.text));
                        },
                        color: Colors.lightBlue,
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: new ListView.builder(
                        itemCount: 1,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialogFunc(context, state.weatherTempMin, state.weatherTempMax);
                              },
                                child: Column(
                                  children: <Widget>[
                                    Text(cityController.text,
                                      style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),),
                                    Text(state.weatherTemp.round().toString() +
                                        "C", style: TextStyle(
                                        color: Colors.blue, fontSize: 30),),
                                    Text("Temprature", style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 14),),
                                  ],
                                )
                                );
                          }),
                    )

                  ],
                ));

          } else if (state is NotSearchedEvent) {
            return Text('no internet :(');
          } else {
            return Text("Error,Error,Error",
                style: TextStyle(color: Colors.white));
          }
        }),
      ),
    );
  }
}

showDialogFunc(context, weatherTempMin, weatherTempMax)  {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  weatherTempMin.round().toString() + "C",
                  style: TextStyle(color: Colors.blue, fontSize: 30),),
                Text("Max Temprature", style: TextStyle(color: Colors.blueGrey, fontSize: 14),),
                SizedBox(
                  height: 10,
                ),
                    Text(weatherTempMax.round().toString() + "C", style: TextStyle(color: Colors.blue, fontSize: 30),),
                    Text("Min Temprature", style: TextStyle(color: Colors.blueGrey, fontSize: 14),),
                SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.lightBlue,
                    child: Text("GO BACK", style: TextStyle(color: Colors.blueGrey, fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}