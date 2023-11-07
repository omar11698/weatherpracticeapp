import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherpracticeapp/core/failures.dart';

import '../../../domain/entities/weather_entity.dart';
import '../../../domain/use_cases/getweatherbycityname_usecase.dart';
part 'get_weather_event.dart';
part 'get_weather_state.dart';

class GetWeatherBloc extends Bloc<GetWeatherEvent, GetWeatherState> {
  final GetWeatherByCityName getWeatherByCityName;

  GetWeatherBloc({required this.getWeatherByCityName})
      : super(GetWeatherInitial())  {
    

    on<GetCityNameEvent>(
        (event, emit) async => await _handleGettingWeatherEvent(event, emit));

  }






   _handleGettingWeatherEvent(
      GetCityNameEvent event, Emitter<GetWeatherState> emit) async {
    emit(GetWeatherLoading());
    (await getWeatherByCityName.execute(event.cityName)).fold(
        (l) => emit(GetWeatherFailed(message:l.message)),
        (r) => emit(GetWeatherSuccess(weather: r)));
  }
}
