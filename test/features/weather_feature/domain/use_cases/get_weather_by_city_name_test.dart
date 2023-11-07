import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weatherpracticeapp/core/failures.dart';
import 'package:weatherpracticeapp/features/weather_feature/domain/entities/weather_entity.dart';
import 'package:weatherpracticeapp/features/weather_feature/domain/repositories/repository.dart';
import 'package:weatherpracticeapp/features/weather_feature/domain/use_cases/getweatherbycityname_usecase.dart';

import '../../../../Repository.Mock.dart';

void main() {
  /// what does this class depends on ?
  /// Repository
  /// how can we create fake version out of it
  /// using Mocktail
  /// how we control what our dependency do ?
  /// Mocktail's APIs
  late final Repository repository;
  late final GetWeatherByCityName useCase;
  // preparing what the unit depend on before any thing runs
  setUpAll(
    () {
      repository = MockRepository();
      useCase = GetWeatherByCityName(repository: repository);
    },
  );
  const cityName = 'cairo';
  const response = Weather.empty();
  // the test we need to do on this unit (class): GetWeatherByCityName
  test(
    'should call [getWeatherByCityName.execute and return Weather Object]',
    () async {
      // Arrange
      when(() => repository.getWeatherByCityName(cityName))
          .thenAnswer((_) async => const Right<Failure,Weather>(response));
      // Act
      final result = await useCase.execute(cityName);
      expect(result.fold((l) => null, (r) => r), equals((response)));

      // Assert
      verify(() => repository.getWeatherByCityName(cityName)).called(2);
      verifyNoMoreInteractions(repository);
    },
  );
}
