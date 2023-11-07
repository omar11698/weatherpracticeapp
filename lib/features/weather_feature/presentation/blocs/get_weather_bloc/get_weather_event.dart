part of 'get_weather_bloc.dart';

abstract class GetWeatherEvent extends Equatable {
  const GetWeatherEvent();
}

class GetCityNameEvent extends GetWeatherEvent{
  final String cityName;
  const GetCityNameEvent({required this.cityName});

  @override

  List<Object?> get props => [cityName];

}
