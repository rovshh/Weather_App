import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _cityInput = '';
  List<String> _lastSearchedCities = [];
  final WeatherFactory _weatherFactory =
      WeatherFactory('b44202c2e1d2cdfa8c37c03463fb7df1');
  Map<String, Weather> _weatherData = {};

  @override
  void initState() {
    super.initState();
    _loadLastSearchedCities();
  }

  Future<void> _loadLastSearchedCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cities = prefs.getStringList('lastSearchedCities') ?? [];
    setState(() {
      _lastSearchedCities = cities;
    });
    for (String city in cities) {
      await _fetchWeather(city);
    }
  }

  Future<void> _saveLastSearchedCity(String city) async {
    city = capitalize(city); // Capitalize the city name
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!_lastSearchedCities.contains(city)) {
      if (_lastSearchedCities.length >= 5) {
        _lastSearchedCities.removeAt(0);
      }
      _lastSearchedCities.add(city);
      await prefs.setStringList('lastSearchedCities', _lastSearchedCities);
    }
  }

  Future<bool> _fetchWeather(String cityName) async {
    try {
      Weather weather =
          await _weatherFactory.currentWeatherByCityName(cityName);
      setState(() {
        _weatherData[cityName] = weather;
      });
      return true;
    } catch (e) {
      print("Error fetching weather data for $cityName: $e");
      return false;
    }
  }

  void _searchCity() async {
    try {
      if (_cityInput.isEmpty ||
          !RegExp(r'^[a-zA-Z\s]*$').hasMatch(_cityInput)) {
        throw Exception('Invalid city name');
      }
      bool isValidCity = await _fetchWeather(_cityInput);
      if (isValidCity) {
        await _saveLastSearchedCity(_cityInput);
        Navigator.pop(context, _cityInput);
      } else {
        throw Exception('City not found');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _selectCity(String city) {
    Navigator.pop(context, city);
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  "Search city",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _cityInput = value;
                      },
                      onSubmitted: (value) {
                        _searchCity();
                      },
                      decoration: InputDecoration(
                        labelText: 'Search for a city',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: _searchCity,
                  ),
                ],
              ),
              if (_lastSearchedCities.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20),
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: _lastSearchedCities.map((city) {
                        Weather? weather = _weatherData[city];
                        return GestureDetector(
                          onTap: () => _selectCity(city),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(251, 185, 211, 1),
                                    Color.fromRGBO(166, 121, 234, 1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (weather != null)
                                        Text(
                                          'H:${weather.tempMax?.celsius?.toStringAsFixed(0)}° L:${weather.tempMin?.celsius?.toStringAsFixed(0)}°',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      Text(
                                        city,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      if (weather != null)
                                        Image.network(
                                          'https://openweathermap.org/img/w/${weather.weatherIcon}.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                      if (weather != null)
                                        Text(
                                          weather.weatherMain ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper function to capitalize the first letter of a string
String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}
