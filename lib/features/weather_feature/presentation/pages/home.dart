import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherpracticeapp/core/constants.dart';
import '../../domain/entities/weather_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../blocs/get_weather_bloc/get_weather_bloc.dart';
import '../widgets/frosted_glass_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xfffeebcf),
              const Color(0xfffee7cb),
              const Color(0xfffee7cb).withOpacity(0.7),
              const Color(0xfff39c7a).withOpacity(0),
            ],
          ),
        ),
        child: BlocBuilder<GetWeatherBloc, GetWeatherState>(
          builder: (context, state) {
          if (state is GetWeatherSuccess) {
              final weather = state.weather;
              return Content(weather: weather);
            }
              else if (state is GetWeatherInitial) {
            context
                    .read<GetWeatherBloc>()
                    .add(const GetCityNameEvent(cityName: "Gazza"));

              return const Center(child: RefreshProgressIndicator());
            }
              else if (state is GetWeatherLoading) {
              return const Center(child: RefreshProgressIndicator());
            }
              else if (state is GetWeatherFailed) {
              return const Center(
                child: Text(
                  'Failed and the data is null',
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'You Can Search Weather freely!',
                ),
              );
            }
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context
      //         .read<GetWeatherBloc>()
      //         .add(const GetCityNameEvent(cityName: "New York"));
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme
      //     .of(context)
      //     .colorScheme
      //     .inversePrimary,
      leading: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController cityNameController =
                    TextEditingController();
                return AlertDialog(
                  title: const Text('City Name'),
                  // icon: ,
                  content: SizedBox(
                    height: 40,
                    width: 200,
                    child: TextField(
                      controller: cityNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter City name',
                      ),
                    ),
                  ),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          context.read<GetWeatherBloc>().add(GetCityNameEvent(
                              cityName: cityNameController.value.text));
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(SvgImagesKeys.magnifierSvg))
                  ],
                );
              });
        },
        child: Container(
          height: 15,
          width: 15,
          padding: const EdgeInsets.only(left: 15),
          child: SvgPicture.asset(
            SvgImagesKeys.magnifierSvg,
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Container(
            height: 40,
            width: 60,
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              SvgImagesKeys.drawerSvg,
            ),
          ),
        ),
      ],
      title: Container(
        height: 20,
        width: 120,
        padding: const EdgeInsets.only(right: 40),
        child: SvgPicture.asset(
          SvgImagesKeys.pointsSvg,
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String dateWithFormat = dateFormat.format(DateTime.now());
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${weather.cityName},",
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                weather.countryName,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                "${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: WeatherRow(weather: weather),
            ),
            SizedBox(
              height: 300,
              width: 400,
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                controller: scrollController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FrostedGlassBox(
                        theWidth: 300,
                        theHeight: 80,
                        theChild: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    padding: EdgeInsets.only(
                                        top: index == 2 ? 10 : 0),
                                    child: index == 2
                                        ? const HumidityWidget()
                                        : SvgPicture.asset(
                                            index == 0
                                                ? SvgIconsKeys.rainfallSvg
                                                : index == 1
                                                    ? SvgIconsKeys.windSvg
                                                    : SvgIconsKeys.humiditySvg,
                                            fit: BoxFit.cover,
                                          ),
                                  )),
                              Text(index == 0
                                  ? "RainFall"
                                  : index == 1
                                      ? "Wind"
                                      : "Humidity"),
                              const SizedBox(
                                width: 150,
                              ),
                              Text(index == 0
                                  ? "3 cm"
                                  : index == 1
                                      ? "${weather.windSpeed ?? 0} km/h"
                                      : '${weather.humidity}%'),
                            ],
                          ),
                        )),
                  );
                },
              ),
            ),
            SizedBox(
              height: 140,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FrostedGlassBox(
                      theWidth: 60,
                      theHeight: 60,
                      theChild: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Day ${index + 1} '),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                height: 60,
                                width: 60,
                                child: SvgPicture.asset(
                                  SvgImagesKeys.sunnyCloudyIconSvg,
                                  fit: BoxFit.cover,
                                )),
                            Text('${19 + index} Cº'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HumidityWidget extends StatelessWidget {
  const HumidityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 22,
        width: 22,
        child: SvgPicture.asset(
          SvgIconsKeys.humiditySvg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class WeatherRow extends StatelessWidget {
  const WeatherRow({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 170,
          width: 170,
          child: SvgPicture.asset(
            weather.main == 'Clear'
                ? SvgImagesKeys.sunnyWeatherIconSvg
                : weather.main == 'Rain'
                    ? SvgImagesKeys.rainyWeatherIconSvg
                    : SvgImagesKeys.sunnyCloudyIconSvg,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 25),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${weather.temp.toInt() - 273}",
                    style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'ºc',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Text(
                weather.description,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
