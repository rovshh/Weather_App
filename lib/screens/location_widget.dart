import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class LocationWidget extends StatelessWidget {
  final Weather? weather;

  const LocationWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${weather?.areaName}, ${weather?.country} ',
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
