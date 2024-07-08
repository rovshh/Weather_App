import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/weather_icon.dart';

class FiveDayForecast extends StatelessWidget {
  final String cityName;
  final double currentTemp;
  final List<Map<String, dynamic>> forecastData;

  const FiveDayForecast({
    super.key,
    required this.cityName,
    required this.currentTemp,
    required this.forecastData,
  });

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, MMM d').format(DateTime.now());

    var uniqueForecastData =
        LinkedHashMap<String, Map<String, dynamic>>.fromIterable(
      forecastData,
      key: (item) => item['day'],
      value: (item) => item,
    ).values.toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(215, 163, 182, 1),
              Color.fromRGBO(84, 56, 127, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '6 Day Forecast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cityName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${currentTemp.toStringAsFixed(0)}°C',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    currentDate,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: uniqueForecastData.length,
                itemBuilder: (context, index) {
                  final item = uniqueForecastData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Lottie.asset(item['icon']),
                          height: MediaQuery.sizeOf(context).height*0.05,),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item['day'],
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${item['maxTemp'].toStringAsFixed(0)}° C / ${item['minTemp'].toStringAsFixed(0)}° C',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
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
