import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialPage extends StatefulWidget {
  final String cityName;
  final String country;
  final int currentTemp;
  final String weatherCondition;
  final String weatherCode;

  const SpecialPage({
    Key? key,
    required this.cityName,
    required this.country,
    required this.currentTemp,
    required this.weatherCondition,
    required this.weatherCode,
  }) : super(key: key);

  @override
  State<SpecialPage> createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 0.8,
            colors: [
              Color.fromRGBO(215, 163, 182, 1),
              Color.fromRGBO(84, 56, 127, 1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  'Bonus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(1),
                child: Text(
                  '${widget.cityName}, ${widget.country} ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(3),
                child: Center(
                  child: Text(
                    '${widget.currentTemp.round().toStringAsFixed(0)}° C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 90,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(3),
                child: Text(
                  widget.weatherCondition,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 1),
                child: Center(
                  child: Text(
                    "Perfect weather for:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                child: Image.asset(
                  drinkIcon(widget.weatherCode, widget.currentTemp),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String drinkIcon(String? code, int? temp) {
    String? condition = code?.toLowerCase();
    if (condition == '13d' ||
        condition == '13n' ||
        condition == '50d' ||
        condition == '50n') {
      return 'assets/tea.png';
    } else if (temp! > 25) {
      switch (code?.toLowerCase()) {
        case '01d':
        case '01n':
        case '02d':
        case '02n':
        case '03d':
        case '03n':
        case '04d':
        case '04n':
          return 'assets/beer.png';
        case '09d':
        case '10d':
        case '09n':
        case '10n':
        case '11d':
        case '11n':
          return 'assets/wine-bottle.png';
      }
    } else {
      switch (code?.toLowerCase()) {
        case '01d':
        case '01n':
        case '02d':
        case '02n':
        case '03d':
        case '03n':
        case '04d':
        case '04n':
          return 'assets/cola.png';
        case '09d':
        case '10d':
        case '09n':
        case '10n':
        case '11d':
        case '11n':
          return 'assets/coffee.png';
      }
    }
    return 'assets/beer.png';
  }
}
