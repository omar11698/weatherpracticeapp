import '../../../../core/failures.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/repository.dart';
import '../data_sources/remote_datasource.dart';
import 'package:dartz/dartz.dart';

class WeatherRepository extends Repository{
  RemoteDataSource remoteDataSource;
  WeatherRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, Weather>> getWeatherByCityName(String cityName) async {
    try{
       return Right(await remoteDataSource.getWeatherByCityName(cityName));
    }
    on WeatherAPIException catch(e) {
      return Left(WeatherAPIException(message: e.toString(), statusCode: 500) );
    }
  }

}