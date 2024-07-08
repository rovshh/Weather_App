String weatherIcon(String? condition) {
  switch (condition?.toLowerCase()) {
    case '01d':
      return 'assets/Clear_day.json';
    case '01n':
      return 'assets/Clear_day.json';
    case '02d':
      return 'assets/Clouds_day.json';
    case '02n':
      return 'assets/Clouds_night.json';
    case '03d':
    case '03n':
    case '04d':
    case '04n':
      return 'assets/Clouds.json';
    case '09d':
    case '10d':
      return 'assets/Rain_day.json';
    case '09n':
    case '10n':
      return 'assets/Rain_night.json';
    case '11d':
    case '11n':
      return 'assets/Thunderstorm.json';
    case '13d':
    case '13n':
      return 'assets/Snow.json';
    case '50d':
    case '50n':
      return 'assets/Mist.json';
    default:
      return 'assets/Clear_day.json';
  }
}
