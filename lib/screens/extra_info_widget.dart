import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class ExtraInfoWidget extends StatelessWidget {
  final Weather? weather;

  const ExtraInfoWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(212, 207, 109, 1),
            Color.fromRGBO(215, 163, 182, 1)
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(top: 25, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Max",
                style: TextStyle(
                  fontSize: 20,
                  color: const Color.fromRGBO(84, 56, 127, 1),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.003),
              Row(
                children: [
                  Text(
                    "${weather?.tempMax?.celsius?.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                  Text(
                    "° C",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Min",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(84, 56, 127, 1),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.003),
              Row(
                children: [
                  Text(
                    "${weather?.tempMin?.celsius?.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                  Text(
                    "° C",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Wind",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(84, 56, 127, 1),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.003),
              Row(
                children: [
                  Text(
                    "${weather?.windSpeed?.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                  Text(
                    " m/s",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                "Humidity",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(84, 56, 127, 1),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.003),
              Row(
                children: [
                  Text(
                    "${weather?.humidity?.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                  Text(
                    " %",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(84, 56, 127, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
