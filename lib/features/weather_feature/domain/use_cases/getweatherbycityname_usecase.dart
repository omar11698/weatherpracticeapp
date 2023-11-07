import 'package:dartz/dartz.dart';
import 'package:weatherpracticeapp/core/failures.dart';

import '../entities/weather_entity.dart';
import '../repositories/repository.dart';

class GetWeatherByCityName{
  Repository repository;

  GetWeatherByCityName({required this.repository});

  Future<Either<Failure, Weather>> execute(String cityName)async{

    print("${ await repository.getWeatherByCityName(cityName).runtimeType}");
    return await repository.getWeatherByCityName(cityName);

  }
}