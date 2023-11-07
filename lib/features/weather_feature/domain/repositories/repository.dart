import 'package:dartz/dartz.dart';

import '../../../../core/failures.dart';
import '../entities/weather_entity.dart';


abstract class Repository{
  Future<Either<Failure ,Weather>>getWeatherByCityName(String cityName);
}
