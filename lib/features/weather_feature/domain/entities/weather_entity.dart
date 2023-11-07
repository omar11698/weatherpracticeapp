import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int id;
  final int pressure;
  final int humidity;
  final dynamic windSpeed;
  final double temp;
  final String cityName;
  final String countryName;
  final String main;
  final String description;
  const Weather(
      {required this.id,
      required this.temp,
      required this.windSpeed,
      required this.countryName,
      required this.humidity,
      required this.pressure,
      required this.cityName,
      required this.main,
      required this.description});
  const Weather.empty()
      : this(
          id: 0,
          pressure: 0,
          humidity: 0,
          windSpeed: 0,
          temp: 100,
          cityName: 'cairo',
          countryName: 'egypt',
          main: '',
          description: '',
        );
  @override
  List<Object?> get props => [
        id,
        pressure,
        humidity,
        windSpeed,
        temp,
        cityName,
        countryName,
        main,
        description,
      ];
}
