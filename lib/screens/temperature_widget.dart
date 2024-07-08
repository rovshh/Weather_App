import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/weather.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather? weather;

  const TemperatureWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            "${weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
            style: TextStyle(
              color: Colors.white,
              fontSize: 90,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          child: Text(
            "Feels like ${weather?.tempFeelsLike?.celsius?.toStringAsFixed(0)}° C",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
