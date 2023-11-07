
import '../../domain/entities/weather_entity.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.id,
    required super.temp,
    required super.countryName,
    required super.humidity,
    required super.pressure,
    required super.cityName,
    required super.main,
    required super.description,
    required super.windSpeed,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        id: json["id"],
        pressure: json['main']['pressure'],
        cityName: json['name'],
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        temp: json['main']['temp'],
        humidity: json['main']['humidity'],
        countryName: json['sys']['country'],
        windSpeed: json['wind']['speed'],
      );
}
