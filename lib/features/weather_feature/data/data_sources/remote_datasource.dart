import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherpracticeapp/core/constants.dart';
import 'package:weatherpracticeapp/core/failures.dart';

import '../models/weather_model.dart';
import 'package:dio/dio.dart';

abstract class RemoteDataSource{
  Future<WeatherModel> getWeatherByCityName(String cityName);
}

class RemoteDataSourceImpl extends RemoteDataSource{
  @override
  Future<WeatherModel> getWeatherByCityName(String cityName) async {
      // if(response.statusCode==200){
      //   print(response.data.toString());
      //   return WeatherModel.fromJson(response.data);
      // }
      // else{
      //   throw Exception("null error happened");
      // }

    try{
      final dio = Dio();
      var response = await dio.get('${Constants.baseUrl}/weather?q=${cityName}&appid=${Constants.apiKey}' ) ;
      return WeatherModel.fromJson(response.data);

    }
    on WeatherAPIException catch (e){
       throw WeatherAPIException(message: e.message, statusCode: e.statusCode);
    }


    }



  }

