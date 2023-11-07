import 'package:get_it/get_it.dart';
import 'package:weatherpracticeapp/features/weather_feature/domain/use_cases/getweatherbycityname_usecase.dart';
import '../features/weather_feature/data/data_sources/remote_datasource.dart';
import '../features/weather_feature/data/repositories/weather_repository.dart';
import '../features/weather_feature/domain/repositories/repository.dart';
import '../features/weather_feature/presentation/blocs/get_weather_bloc/get_weather_bloc.dart';

final instance = GetIt.instance;
Future<void> intiAppModule()async{

// remote data source
  instance.registerLazySingleton<RemoteDataSource>(
          () =>RemoteDataSourceImpl());
// repository
  instance.registerLazySingleton<Repository>(() => WeatherRepository(instance()));
}

initGetWeatherModule() {
  if (!GetIt.I.isRegistered<GetWeatherByCityName>()) {
    instance
        .registerFactory<GetWeatherByCityName>(() => GetWeatherByCityName(repository:instance()));
    instance
        .registerFactory<GetWeatherBloc>(() => GetWeatherBloc(getWeatherByCityName:instance()));
  }
}

