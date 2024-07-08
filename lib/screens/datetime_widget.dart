import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class DateTimeWidget extends StatelessWidget {
  final Weather? weather;

  const DateTimeWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return Container();
    }
    DateTime now = weather!.date!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          DateFormat.Hm().format(now),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.006),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              DateFormat(', dd.MM.yyyy').format(now),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
