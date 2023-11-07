import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

}

class WeatherAPIException extends Failure implements Exception {


  const WeatherAPIException({required super.message, required super.statusCode});

  @override
  List<Object?> get props => [message,statusCode];

}
