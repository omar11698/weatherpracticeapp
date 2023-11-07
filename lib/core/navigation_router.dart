
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherpracticeapp/core/DI.dart';

import '../features/weather_feature/presentation/pages/home.dart';

const String homeRoute='/';


class NavigationRouter{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case homeRoute:
        initGetWeatherModule();
        return MaterialPageRoute(builder: (_) => const MyHomePage(title: "GetWeather"));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}