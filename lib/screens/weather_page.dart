import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/screens/five_day_forecast.dart';
import 'package:weather_app/screens/search_page.dart';
import 'package:weather_app/screens/location_widget.dart';
import 'package:weather_app/screens/datetime_widget.dart';
import 'package:weather_app/screens/special_page.dart';
import 'package:weather_app/screens/temperature_widget.dart';
import 'package:weather_app/screens/extra_info_widget.dart';
import 'package:weather_app/screens/weather_icon.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherFactory _weatherFactory =
      WeatherFactory('OpenWeatherMap API Key');
  Weather? _weather;
  List<Weather> _forecast = [];
  String _cityName = 'Worcester';
  final Uri _url = Uri.parse('https://karimsaliev.github.io/weather/');

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(215, 163, 182, 1),
              Color.fromRGBO(84, 56, 127, 1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Center(
                  child: Text(
                    "Weather App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon:
                        Icon(Icons.star_rounded, color: Colors.white, size: 30),
                    onPressed: () {
                      if (_weather != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpecialPage(
                                      cityName: _weather!.areaName!,
                                      country: _weather!.country!,
                                      currentTemp: _weather!.temperature!.celsius!.toInt(),
                                      weatherCondition: _weather!.weatherMain!,
                                      weatherCode: _weather!.weatherIcon!,
                                    )));
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white, size: 30),
                    onPressed: () async {
                      final cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()),
                      );
                      if (cityName != null && cityName is String) {
                        setState(() {
                          _cityName = cityName;
                        });
                        _fetchWeather(cityName: cityName);
                      }
                    },
                  ),
                ],
              ),
              if (_weather == null) Center(child: CircularProgressIndicator()) else Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refreshWeather,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(height: size.height * 0.01),
                              Container(
                                  padding: EdgeInsets.all(3),
                                  child: Center(
                                      child:
                                          LocationWidget(weather: _weather))),
                              ClipRect(
                                  child: DateTimeWidget(weather: _weather)),
                              Container(
                                  child: TemperatureWidget(weather: _weather)),
                              GestureDetector(
                                onDoubleTap: () {
                                  _launchUrl();
                                },
                                child: Container(
                                  height: size.height * 0.3,
                                  child: Lottie.asset(
                                      weatherIcon(_weather?.weatherIcon)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 17),
                                child: Container(
                                    child: ExtraInfoWidget(weather: _weather)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 14, top: 10, right: 14),
                                    child: TextButton(
                                      child: Row(
                                        children: [
                                          Text(
                                            "Six Day Forecast ",
                                            style: TextStyle(
                                              fontSize: 27,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 32,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FiveDayForecast(
                                              cityName: _weather!.areaName!,
                                              currentTemp: _weather!.temperature!.celsius!,
                                              forecastData: _forecast.map((weather) {
                                                return {
                                                  "day": DateFormat('EEEE').format(weather.date!),
                                                  "icon": weatherIcon(weather.weatherIcon),
                                                  "maxTemp":
                                                      weather.tempMax!.celsius!,
                                                  "minTemp":
                                                      weather.tempMin!.celsius!,
                                                };
                                              }).toList(),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchWeather({String? cityName}) async {
    try {
      String city = cityName ?? await getCurrentCity();
      Weather weather = await _weatherFactory.currentWeatherByCityName(city);
      List<Weather> forecast =
          await _weatherFactory.fiveDayForecastByCityName(city);
      setState(() {
        _weather = weather;
        _forecast = forecast;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String? cityName = placemarks[0].locality;
    return cityName ?? "";
  }

  Future<void> _refreshWeather() async {
    await _fetchWeather();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
