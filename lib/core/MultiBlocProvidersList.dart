import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/weather_feature/presentation/blocs/get_weather_bloc/get_weather_bloc.dart';
import 'DI.dart';

class MultiBlocProvidersList{

  static  blocProvidersList(BuildContext context){

   return  [
     BlocProvider<GetWeatherBloc>(
       create: (context) => GetWeatherBloc(getWeatherByCityName: instance()),
      ),

    ];

  }
}