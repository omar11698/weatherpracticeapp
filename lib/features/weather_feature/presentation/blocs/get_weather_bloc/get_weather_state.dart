part of 'get_weather_bloc.dart';

abstract class GetWeatherState extends Equatable {
  const GetWeatherState();
}

class GetWeatherInitial extends GetWeatherState {
  @override
  List<Object> get props => [];
}

class GetWeatherLoading extends GetWeatherState {
  @override
  List<Object> get props => [];
}

class GetWeatherSuccess extends GetWeatherState {
final Weather weather;

const GetWeatherSuccess({required this.weather});

  @override
  List<Object> get props => [];
}

class GetWeatherFailed extends GetWeatherState {
  final String message;

  const GetWeatherFailed({required this.message});

  @override
  List<Object> get props => [];
}
